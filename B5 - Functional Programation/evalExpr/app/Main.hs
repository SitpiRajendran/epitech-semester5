module Main where
import System.Environment
import System.Exit
import Control.Applicative
import Text.Printf

-- Datas
data Parser a = Parser { 
    runParser :: String -> Maybe (a, String)
}

data Calc = Add Calc Calc
        | Sub Calc Calc
        | Mul Calc Calc
        | Div Calc Calc
        | Pow Calc Calc
        | Nbr Float
        deriving (Show)

-- Functor, Alternative, and Applicative <$> <*> <|>
instance Functor Parser where
    fmap fct parser = Parser (
        \str -> case runParser parser str of
            Nothing -> Nothing
            Just (a, ax) -> Just (fct a, ax))

instance Applicative Parser where
    pure a = Parser (
        \str -> Just(a, str))
    parserA <*> parserB = Parser (
        \str -> case runParser parserA str of
            Nothing -> Nothing
            Just (a, ax) -> case runParser parserB ax of
                Nothing -> Nothing
                Just (b, bx) -> Just (a b, bx))

instance Alternative Parser where
    empty = Parser (const Nothing)
    parserA <|> parserB = Parser (
        \str -> runParser parserA str <|> runParser parserB str)



-- Functions
parseChar :: Char -> Parser Char
parseChar a = Parser (
    \str -> case str of
       [] -> Nothing
       (b:bx) -> case filter (a==) [b] of
           [] -> Nothing
           _ -> Just (b, bx))

parseAnyChar :: String -> Parser Char
parseAnyChar list = Parser (
    \str -> case str of
        [] -> Nothing
        (a:ax) -> case filter (a==) list of
            [] -> Nothing
            _ -> Just (a, ax))

parseSome :: Parser a -> Parser [a]
parseSome parseA = Parser funct
    where funct = (\str -> case str of
            [] -> Nothing
            _ -> case runParser parseA str of
                    Nothing -> Nothing
                    Just (a, ax) -> case funct ax of
                        Nothing -> Just ([a], ax)
                        Just (b, bx) -> Just (a:b, bx))

parseUInt :: Parser Float
parseUInt = Parser (
     \str -> case runParser (parseSome (parseAnyChar ('.':['0'..'9']))) str of
        Nothing -> Nothing
        Just (a, ax) -> (Just (read a::Float, ax)))

parseInt :: Parser Float
parseInt = Parser (
    \str -> case runParser (parseSome (parseChar '-')) str of
        Nothing -> runParser parseUInt str
        Just (_, s1) -> case runParser parseUInt s1 of
            Nothing -> Nothing
            Just (a, ax) -> Just (a * (-1), ax))

-- Programm
binOp :: (Calc -> Calc -> a) -> Char -> Parser Calc -> Parser Calc -> Parser a
binOp opFunc c func before = opFunc <$> func <*> (parseChar c *> before)

makeCalcul :: Calc -> Float
makeCalcul (Add a b) = (makeCalcul a) + (makeCalcul b)
makeCalcul (Sub a b) = (makeCalcul a) - (makeCalcul b)
makeCalcul (Mul a b) = (makeCalcul a) * (makeCalcul b)
makeCalcul (Div a b) = (makeCalcul a) / (makeCalcul b)
makeCalcul (Pow a b) = (makeCalcul a) ** (makeCalcul b)
makeCalcul (Nbr a) = a

parser :: Parser Calc
parser = sum
        where sum = binOp Add '+' mul sum <|> minus
              minus = binOp Sub '-' mul sum <|> mul
              mul = binOp Mul '*' pow mul <|> div
              div = binOp Div '/' pow mul <|> pow
              pow = binOp Pow '^' factor pow <|> factor
              factor = parens <|> nbr
              parens = parseChar '(' *> parser <* parseChar ')'
              nbr = Nbr <$> parseInt

getResult :: Maybe(a, String) -> Maybe a
getResult result = case result of
    Just (res, _) -> Just (res)
    _ -> Nothing

evalExpr :: String -> IO()
evalExpr str = case a of
    Nothing -> putStr "Error\n" >> exitWith(ExitFailure 84)
    Just(x) -> printf "%.2f" $ x
    where
        a = ((fmap makeCalcul) $ getResult $
            runParser parser $ concat $ words str)

main :: IO ()
main = do
    args <- getArgs
    case length args of 
        1 -> evalExpr $ head args
        _ -> putStrLn "USE: ./funEvalExpr 'calc'" >> exitWith (ExitFailure 84)
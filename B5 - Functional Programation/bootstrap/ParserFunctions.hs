module ParserFunctions(Parser, evalExpr) where

import Data.Maybe
import Control.Applicative

data Parser a = Parser {
    runParser :: String -> Maybe (a, String)
}

data Expr = Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
          | Div Expr Expr
          | Pow Expr Expr
          | Lit Float
          deriving (Show)

instance Functor Parser where
    fmap fct parser = Parser (\str -> case runParser parser str of
        Nothing -> Nothing
        Just (a, sstr) -> Just (fct a, sstr))

instance Applicative Parser where
    pure x = Parser (\s -> Just (x, s))
    parser1 <*> parser2 = Parser (\str -> case runParser parser1 str of
        Nothing -> Nothing
        Just (a, sstr) -> case runParser parser2 sstr of
            Nothing -> Nothing
            Just (b, ssstr) -> Just (a b, ssstr))

instance Alternative Parser where
    empty = Parser (const Nothing)
    parser1 <|> parser2 =
        Parser (\str -> runParser parser1 str <|> runParser parser2 str)

pow :: Float -> Float -> Float
pow x n | n <= 0 = x
pow x n = pow (x * x) n -1

eval :: Expr -> Float
eval e = case e of
  Add a b -> eval a + eval b
  Sub a b -> eval a - eval b
  Mul a b -> eval a * eval b
  Div a b -> eval a / eval b
  Pow a b -> pow (eval a) (eval b)
  Lit n -> n

parseChar :: Char -> Parser Char
parseChar c = Parser (
    \str -> case str of
        [] -> Nothing
        (s:sx) -> if c == s
            then Just (c, sx)
            else Nothing)

parseAnyChar :: String -> Parser Char
parseAnyChar chars = Parser (\str -> case str of
  [] -> Nothing
  (c:cs) -> case filter (c==) chars of
    [] -> Nothing
    _ -> Just (c, cs))

parseAnd :: Parser a -> Parser b -> Parser (a, b)
parseAnd parserA parserB = Parser (\str ->
  let resA = runParser parserA str
      resB = if isNothing resA
              then Nothing
              else runParser parserB (snd (fromJust resA))
      status = isNothing resA || isNothing resB
  in case status of
    True -> Nothing
    _ -> Just ((fst(fromJust resA), fst(fromJust resB)), snd(fromJust resB)))

parseAndWith :: (a -> b -> c) -> Parser a -> Parser b -> Parser c
parseAndWith fnc parserA parserB = Parser (\str ->
    let resA = runParser parserA str
        resB = case resA of
            Nothing -> Nothing
            Just (a, b) -> runParser parserB b
        status = isNothing resA || isNothing resB
    in case status of
        True -> Nothing
        _ -> Just (fnc (fst(fromJust resA)) (fst(fromJust resB)),
            snd(fromJust resB)))

parseMany :: Parser a -> Parser [a]
parseMany parser = Parser fnc
    where fnc = (\str -> case str of
            [] -> Just ([], "")
            _ -> let result = runParser parser str
                    in case result of
                        Nothing -> Just ([], str)
                        Just (f, s) -> let (Just (arr, restStr)) = fnc s
                            in Just ((f:arr, restStr)))

parseSome :: Parser a -> Parser [a]
parseSome parser = (:) <$> parser <*> parseMany parser

parseFloat :: Parser Float
parseFloat = read <$> ((parseAndWith fnc (parseChar '-') floatParser) <|> floatParser)
           where fnc = (\x y -> x:y)
                 floatParser = (parseSome (parseAnyChar ('.':['0'..'9'])))

getResult :: Maybe (a, String) -> Maybe a
getResult result = case result of
  Just (res, _) -> Just res
  _ -> Nothing

parser :: Parser Expr
parser = sum
        where sum = binOp Add '+' mul sum <|> binOp Sub '-' mul sum <|> mul
              mul = binOp Mul '*' pow  mul <|> binOp Div '/' pow mul <|> pow
              pow = binOp Pow '^' factor pow <|> factor
              factor = parens <|> lit
              lit = Lit <$> parseFloat
              parens = parseChar '(' *> parser <* parseChar ')'
              binOp opFnc op fnc prev = opFnc <$> fnc <*> (parseChar op *> prev)

evalExpr :: String -> Float
evalExpr str = fromJust
    ((fmap eval) $ getResult $ runParser parser $ concat $ words str)

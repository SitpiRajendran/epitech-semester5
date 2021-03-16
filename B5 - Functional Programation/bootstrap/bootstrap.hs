import Data.Maybe
import Control.Applicative

-- Step 1.1
--type Parser a = String -> Maybe (a, String)

-- Step 1.1.1

-- Step 1.2.1
{- parseChar :: Char -> Parser Char
parseChar a (b:bx)
    | a == b = Parser (Just (b, bx))
    | otherwise = Parser (Nothing)
-}

-- Step 1.2.2
{- parseAnyChar :: String -> Parser Char
parseAnyChar _ [] = Nothing
parseAnyChar [] _ = Nothing
parseAnyChar (a:ax) (b:bx)
    | a == b = Just (a, bx)
    | otherwise = parseAnyChar ax (b:bx) -}

 -- Step 1.3.1
{- parseOr :: Parser a -> Parser a -> Parser a
parseOr _parseA _parseB _str =
    case (_parseA _str) of
        Nothing -> (_parseB _str)
        _ -> _parseA _str -}


--- Step 1.3.2
{- parseAnd :: Parser a -> Parser b -> Parser (a,b)
parseAnd parseA parseB str =
    case parseA str of
        Nothing -> Nothing
        Just (x, s1) -> case parseB s1 of
            Nothing -> Nothing
            Just (y, s2) -> Just ((x, y), s2) -}
-- Step 1.3.3
{- parseAndWith :: (a -> b -> c) -> Parser a -> Parser b -> Parser c
parseAndWith func parseA parseB str =
    case parseA str of
        Nothing -> Nothing
        Just (x, s1) -> case parseB s1 of
            Nothing -> Nothing
            Just (y, s2) -> Just (func x y, s2) -}

-- Step 1.3.4
{- parseMany :: Parser a -> Parser [a]
parseMany parseA str =
    case parseA str of
        Nothing -> (Just ([], str))
        Just (x, s1) -> case (parseMany parseA s1) of
            Nothing -> Just ([x], s1) 
            Just (y, s2) -> Just ([x] ++ y, s2) -}

-- Step 1.3.5
{- parseSome :: Parser a -> Parser [ a ]
parseSome parseA str =
    case parseA str of
        Nothing -> Nothing
        Just (x, s1) -> case (parseMany parseA s1) of
            Nothing -> Nothing
            Just (y, s2) -> Just ([x] ++ y, s2) -}
            -- Step 1.4.1
{- parseUInt :: Parser Int
parseUInt str =
    case parseSome (parseAnyChar ['0'..'9']) str of
        Nothing -> Nothing
        Just (nb, s1) -> Just ((read nb::Int), s1) -}
{-
parseInt :: Parser Int
parseInt str =
    case parseSome (parseChar '-') str of
        Nothing -> parseUInt str
        Just (_, s1) -> case parseUInt s1 of
            Nothing -> Nothing
            Just (x, x1) -> Just (x * (-1), x1)
 -}

-- Step 2.1
data Parser a = Parser { 
    runParser :: String -> Maybe (a, String)
}

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

parseOr :: Parser a -> Parser a -> Parser a
parseOr _parseA _parseB = Parser (
    \str -> case (runParser _parseA str) of
        Nothing -> (runParser _parseB str)
        _ -> (runParser _parseA str))
{- parseOr parserA parserB = Parser (
    \str -> parserA <|> parserB str) -}

parseAnd :: Parser a -> Parser b -> Parser (a,b)
parseAnd parseA parseB = Parser (
    \str -> case (runParser parseA str) of
        Nothing -> Nothing
        Just (x, s1) -> case (runParser parseB s1) of
            Nothing -> Nothing
            Just (y, s2) -> Just ((x, y), s2))

parseAndWith :: (a -> b -> c) -> Parser a -> Parser b -> Parser c
parseAndWith func parseA parseB = Parser (
    \str -> case (runParser parseA str) of
        Nothing -> Nothing
        Just (x, s1) -> case (runParser parseB s1) of
            Nothing -> Nothing
            Just (y, s2) -> Just (func x y, s2))

parseMany :: Parser a -> Parser [a]
parseMany parseA = Parser funct
    where funct = (\str -> case str of
            [] -> (Just ([], ""))
            _ -> case runParser parseA str of
                    Nothing -> Just ([], str)
                    Just (a, ax) -> let (Just (b, bx)) = funct ax
                        in Just (a:b, bx))

parseSome :: Parser a -> Parser [a]
parseSome parseA = Parser funct
    where funct = (\str -> case str of
            [] -> Nothing
            _ -> case runParser parseA str of
                    Nothing -> Nothing
                    Just (a, ax) -> case funct ax of
                        Nothing -> Just ([a], ax)
                        Just (b, bx) -> Just (a:b, bx))

parseUInt :: Parser Int
parseUInt = Parser (
     \str -> case runParser (parseSome (parseAnyChar ['0'..'9'])) str of
        Nothing -> Nothing
        Just (a, ax) -> (Just (read a::Int, ax)))
--      Just (a, ax) -> read <$> Just (a, ax)) -}

parseInt :: Parser Int
parseInt = Parser (
    \str -> case runParser (parseSome (parseChar '-')) str of
        Nothing -> runParser parseUInt str
        Just (_, s1) -> case runParser parseUInt s1 of
            Nothing -> Nothing
            Just (a, ax) -> Just (a * (-1), ax))
--            Just (a, ax) -> (\s -> (-1) * s) <$> Just (a, ax))

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

{- 
[(+),(*)] <*> [1,2] <*> [3,4]
[(1+),(2+),(1*),(2*)] <*> [3,4]
(1+3),1+4, 2+3, 2+4, 1*3, 1*4, 2*3, 2*4
4 5 - 5 6 - 3 4 - 6 8
 -}
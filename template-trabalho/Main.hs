module Main where

import Test.HUnit
import Control.Applicative
import Functions

main :: IO ()
main = runTestTT tests >> return ()

tests = TestList $ concat [facTest, fibTest]

facTest = funcTest "fac" fac [0, 1, 2, 10] [1, 1, 2, 3628800]

fibTest = funcTest "fib" fib [0, 1, 2, 10] [0, 1, 1, 55]

funcTest :: (Show a, Show b, Eq b) => String -> (a -> b) -> [a] -> [b] -> [Test]
funcTest name f xs ys = [TestCase (assertEqual (getStr x) y (f x)) | (x, y) <- zip xs ys]
  where getStr x = "Testando " ++ name ++ " " ++ show x

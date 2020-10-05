module Main where

import LexLE
import ParLE
import AbsLE
import Interpreter

import ErrM

main = do
  interact calc
  putStrLn ""

calc s = 
  let Ok e = pExp (myLexer s) 
  in show (eval e)

module Interpreter where

import AbsLE

eval :: Exp -> Integer
eval x = case x of
    EAdd exp0 exp  -> eval exp0 + eval exp
    ESub exp0 exp  -> eval exp0 - eval exp
    EMul exp0 exp  -> eval exp0 * eval exp
    EDiv exp0 exp  -> eval exp0 `div` eval exp
    EInt n  -> n
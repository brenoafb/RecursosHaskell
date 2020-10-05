module SkelLE where

-- Haskell module generated by the BNF converter

import AbsLE
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transExp :: Exp -> Result
transExp x = case x of
  EAdd exp1 exp2 -> failure x
  ESub exp1 exp2 -> failure x
  EMul exp1 exp2 -> failure x
  EDiv exp1 exp2 -> failure x
  EInt integer -> failure x


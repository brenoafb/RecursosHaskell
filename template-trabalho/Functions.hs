module Functions where

-- Implemente a função fatorial
fac :: Int -> Int
fac 0 = 1
fac n = n * (fac $ n - 1)

-- Implemente a função de Fibonacci
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)


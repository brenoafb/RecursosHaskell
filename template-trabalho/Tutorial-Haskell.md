# Tutorial Haskell

Veremos como instalar e utilizar a plataforma Haskell.

Os principais componentes da plataforma Haskell são:

- GHC: compilador
- GHCi: plataforma interativa (REPL)

## Instalação

A maneira mais fácil de se instalar a plataforma Haskell é pelo script GHCUp,
disponível no [link](https://www.haskell.org/ghcup/).

Para instalar em sistemas Unix (Linux, macOS, BSD), basta inserir o comando seguinte no terminal:

```
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

Caso esteja usando Windows, consulte o link do GHCUp.

## Programação básica com o GHCi

Para se familiarizar com a sintaxe da linguagem, use o GHCi para inserir
comandos e obter o resultado imediatamente.

```bash
$ ghci
GHCi, version 8.6.5: http://www.haskell.org/ghc/  :? for help
Loaded package environment from /home/breno/.ghc/x86_64-linux-8.6.5/environments/default
Prelude >
```

Comandos em Haskell são expressões, por exemplo:

```bash
Prelude > 3 + 1
4
Prelude > x = 4
Prelude > x + 3
8
```

Podemos definir funções da seguinte forma:

```bash
Prelude > square x = x * x

Chamadas de função seguem o padrão `<função> <arg 1> ... <arg n>`.

```bash
Prelude > square 3
9
```

Funções de diversos parametros são definidas de maneira análoga.

```bash
Prelude > sumOfSquares x y = square x + square y
Prelude > sumOfSquares 3 4
25
```

Por fim, para finalizar o GHCi, use o comando `:q`.

## Programando fora do GHCi

Vejamos agora como criar um programa básico para ser compilado e executado.
Crie o arquivo `Main.hs` e insira o programa a seguir.

```haskell
module Main where

main = putStrLn "Hello world!"
```

Compile com o GHC e execute.

```bash
$ ghc Main.hs
Loaded package environment from /home/breno/.ghc/x86_64-linux-8.6.5/environments/default
[1 of 1] Compiling Main             ( Main.hs, Main.o )
Linking Main ...
$ ./Main
Hello world!
```

Vejamos agora como definir uma função com múltiplas cláuslas.
Em `Main.hs`, substitua o conteúdo por

```haskell
module Main where

main = putStrLn (show (test 0))

test :: Int -> Bool
test 0 = True
test n = False
```

A função simplesmente testa se o número fornecido é zero.
Compilando e executando o programa, obtemos o resultado.

```bash
$ ghc Main.hs
Loaded package environment from /home/breno/.ghc/x86_64-linux-8.6.5/environments/default
[1 of 1] Compiling Main             ( Main.hs, Main.o )
Linking Main ...
$ ./Main
True
```

A linha `test :: Int -> Bool` enuncia o tipo da função.
Nesse caso, `test` recebe um `Int` e retorna um `Bool`.
Em Haskell, tipos de valores e funções são inferidos, então não é sempre
necessário preencher o tipo das funções declaradas.
O typechecker do Haskell, porém, é uma ferramenta poderosa de desenvolvimento,
e pode ser utilizada para evitar bugs e guiar o desenvolvimento.

## Completando um programa exemplo

Nessa seção vamos ver como completar um programa e testar os resultados gerados.
Antes de tudo, é necessário instalar uma biblioteca externa.
Essa biblioteca se chama `HUnit`, e é utilizada para escrever e executar testes
unitários.

Bibliotecas de Haskell são gerenciadas pelo programa `cabal`, que é instalado
pelo GHCUp.
Para instalar o `cabal`, usamos o comando a seguir.

```bash
$ cabal install --lib HUnit
```



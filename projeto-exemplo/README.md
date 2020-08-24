# Instruções

## Instalação da plataforma Stack

Para executar esse projeto, é necessário que se instale a plataforma
Stack.

Para sistemas Unix-like (Linux, macOS), basta rodar o comando

```
curl -sSL https://get.haskellstack.org/ | sh
```

ou

```
wget -qO- https://get.haskellstack.org/ | sh
```

Para mais detalhes e para instalação no Windows, ver a [página da ferramenta](https://docs.haskellstack.org/en/stable/README/).

## Configuração de ambiente

Antes de tudo, é necessário que o Stack configure a versão correta
do compilador GHC e dos pacotes.
No diretório do projeto, execute o comando a seguir.

```
$ stack setup
```

Após isso, execute o comando `$ stack test --fast`.
O comando pode demorar um pouco se é a primeira vez que você está
rodando.
Certifique-se que os testes rodam e falham.

```
trabalho> test (suite: trabalho-test)

Progress 1/2: trabalho
fibonacci
  fibonacci 0 = 0 FAILED [1]
  fibonacci 1 = 1 FAILED [2]
  fibonacci 10 = 55 FAILED [3]

...

Finished in 0.0043 seconds
12 examples, 12 failures

trabalho> Test suite trabalho-test failed
Completed 2 action(s).
Test suite failure for package trabalho-0.1.0.0
    trabalho-test:  exited with: ExitFailure 1
Logs printed to console
```

## Desenvolvimento e testes

Agora implemente as funções no arquivo `src/Lib.hs`.

Se quiser testar, basta rodar novamente o comando
`stack test --fast`.
É possível também executar o comando `stack test --file-watch --fast`,
que roda os testes automaticamente após cada mudança nos arquivos
de código fonte.



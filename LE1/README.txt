Nota��o:
"=>" edi��o de arquivo
"==>" execu��o de comando no prompt do sistema operacional


** Passos principais (requerido no curso, feito pelo aluno)

1) estudar a sintaxe abstrata, ou seja, o(s) tipo(s) alg�brico(s) com a estrutura da linguagem 
  => arquivo "AbsLE.hs"

2) definir/editar o interpretador com base na sintaxe abstrata 
  => arquivo "Interpreter.hs"

3) compilar o driver (main) do interpretador 
  ==> ghc --make Interpret.hs

4) testar o execut�vel com exemplos:
  ==> Interpret < ex1.le1   

** Passos preliminares (feito pelo professor)
-3) Definir/editar a sintaxe concreta (feito pelo professor)
  ==> arquivo LE1.cf

-2) Gerar os fontes do analisador sint�tico (parser) e l�xico (lexer), assim como o Makefile usando o BNF Converter
  ==> bnfc  -m  LE1.cf

-1) Compilar os fontes do parser e lexer 
  ==> make

0) Definir o driver (main) do interpretador
  => arquivo "Interpret.hs"
   

---------------------

Observa��es

-> O arquivo "Abs.hs" � gerado a partir do arquivo "LE1.cf". Assim, caso o �ltimo seja editado, o primeiro ter� que ser gerado
novamente. Para fazer altera��es desejadas no arquivo "Abs.hs", o mesmo n�o deve ser editado diretamente: 
deve-se alterar o "LE1.cf" e gerar o "Abs.hs" novamente usando o BNF Converter.

-> Para a execu��o dos "Passos Principais", � necess�rio ter a plataforma Haskell instalada.
https://www.haskell.org/platform/

-> Para a execu��o dos "Passos Preliminares", � necess�rio:
1) instalar o BNF Converter
http://bnfc.digitalgrammars.com/

2) Caso o sistema operacional n�o tenha nativamente o "make" (p.ex. Windows),
� necess�rio instal�-lo
http://www.steve.org.uk/Software/make/   
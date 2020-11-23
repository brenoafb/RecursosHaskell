# LI2

Para compilar o programa.

```
$ make
```

Para executar com um arquivo de entrada e gerar a árvore sintática.

```bash
$ ./TestLI examples/ex1.li7

examples/ex1.li7

Parse Successful!

[Abstract Syntax]

Prog [Fun Tint (Ident "main") [] [SDec (Dec Tint (Ident "x")),SAss (Ident "x") (EInt 2),SReturn (EVar (Ident "x"))]]

[Linearized tree]

int main () {
  int x;
  x = 2;
  return x;
  }
```


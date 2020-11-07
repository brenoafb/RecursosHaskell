module UnBCare where

import ModeloDados
import qualified Data.List as L

{-
                                         UnBCare <<Logo>>

O objetivo desse trabalho é fornecer apoio ao gerenciamento de cuidados a serem prestados a um paciente.
O paciente tem um receituario médico, que indica os medicamentos a serem tomados com seus respectivos horários.
Esse receituário é organizado em um plano de medicamentos que estabelece, por horário, quais são os remédios a serem
tomados. Cada medicamento tem um nome e uma quantidade de  comprimidos que deve ser ministrada.
Um cuidador de plantão é responsável por ministrar os cuidados ao paciente, seja ministrar medicamento, seja comprar medicamento.
Eventualmente, o cuidador precisará comprar medicamentos para cumprir o plano.
O modelo de dados do problema (definições de tipo) está disponível no arquivo ModeloDados.hs
Defina funções que simulem o comportamento descrito acima e que estejam de acordo com o referido
modelo de dados.

-}



{-

QUESTÃO 1, VALOR: 1,0 ponto

Defina a função "comprarMedicamento", cujo tipo é dado abaixo e que, a partir de um medicamento, uma quantidade e um
estoque inicial de medicamentos, retorne um novo estoque de medicamentos contendo o medicamento adicionado da referida
quantidade. Se o medicamento já existir na lista de medicamentos, então a sua quantidade deve ser atualizada no novo estoque.
Caso o remédio ainda não exista no estoque, o novo estoque a ser retornado deve ter o remédio e sua quantidade como cabeça.

comprarMedicamento :: Medicamento -> Quantidade -> EstoqueMedicamentos -> EstoqueMedicamentos

-}

-- comprarMedicamento :: Medicamento -> Quantidade -> EstoqueMedicamentos -> EstoqueMedicamentos
-- comprarMedicamento m q xs = go xs m q xs
--   where go init m q [] = (m,q):init
--         go init m q ((m',q'):xs)
--           | m == m' = (m, q):xs
--           | otherwise = (m',q') : go init m q xs

comprarMedicamento :: Medicamento -> Quantidade -> EstoqueMedicamentos -> EstoqueMedicamentos
comprarMedicamento m q xs =
  if not .null $ filter (\(x,_) -> x == m) xs
  then update m q xs
  else (m,q) : xs

update :: (Eq a, Num b) => a -> b -> [(a,b)] -> [(a,b)]
update _ _ [] = error "update: element not in assoc list"
update x y ((x',y'):xs)
  | x == x' = (x,y + y'):xs
  | otherwise = (x',y') : update x y xs

{-
QUESTÃO 2, VALOR: 1,0 ponto

Defina a função "tomarMedicamento", cujo tipo é dado abaixo e que, a partir de um medicamento e de um estoque de medicamentos,
retorna um novo estoque de medicamentos, resultante de 1 comprimido do medicamento ser ministrado ao paciente.
Se o medicamento não existir no estoque, Nothing deve ser retornado. Caso contrário, deve se retornar Just v,
onde v é o novo estoque.

tomarMedicamento :: Medicamento -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos

-}

tomarMedicamento :: Medicamento -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos
tomarMedicamento _ [] = Nothing
tomarMedicamento med (p@(med', qtd):xs)
  | med == med' && qtd > 0  = Just $ (med', qtd-1) : xs
  | med == med' && qtd <= 0 = Nothing
  | otherwise               = (p :) <$> tomarMedicamento med xs

{-
QUESTÃO 3  VALOR: 1,0 ponto

Defina a função "consultarMedicamento", cujo tipo é dado abaixo e que, a partir de um medicamento e de um estoque de
medicamentos, retorne a quantidade desse medicamento no estoque.
Se o medicamento não existir, retorne 0.

consultarMedicamento :: Medicamento -> EstoqueMedicamentos -> Quantidade

-}

consultarMedicamento :: Medicamento -> EstoqueMedicamentos -> Quantidade
consultarMedicamento med [] = 0
consultarMedicamento med (p@(med', qtd):xs)
  | med == med' = qtd
  | otherwise = consultarMedicamento med xs

{-
  QUESTÃO 4  VALOR: 1,0 ponto

  Defina a função "demandaMedicamentos", cujo tipo é dado abaixo e que computa a demanda de todos os medicamentos
  por um dia a partir do receituario. O retorno é do tipo EstoqueMedicamentos e deve ser ordenado lexicograficamente
  pelo nome do medicamento.

  Dica: Observe que o receituario lista cada remédio e os horários em que ele deve ser tomado no dia.
  Assim, a demanda de cada remédio já está latente no receituario, bastando contar a quantidade de vezes que cada remédio
  é tomado.

  demandaMedicamentos :: Receituario -> EstoqueMedicamentos

-}

-- something weird happening with this function
-- sort snd has type Ord b => [(a,b)] -> [(a,b)], which is normal,
-- but sort fst has type Ord b => [(b,b)] -> [(b,b)].
-- What is going on here?
sort :: Ord a => (t a -> a) -> [t a] -> [t a]
sort _ [] = []
sort ext (x:xs) = sort ext ls ++ [x] ++ sort ext rs
  where ls = filter (\y -> ext y <= ext x) xs
        rs = filter (\y -> ext y >  ext x) xs

qsort [] = []
qsort (x:xs) = qsort (filter (<=x) xs) ++ [x] ++ qsort (filter (>x) xs)

demandaMedicamentos :: Receituario -> EstoqueMedicamentos
demandaMedicamentos = qsort . map (\(med, horarios) -> (med, length horarios))

{-

   QUESTÃO 5  VALOR: 1,0 ponto, sendo 0,5 para cada função.

 Um receituário é válido se, e somente se, todo os medicamentos são distintos e estão ordenados lexicograficamente e,
 para cada medicamento, seus horários também estão ordenados e são distintos.

 Inversamente, um plano de medicamentos é válido se, e somente se, todos seus horários também estão ordenados e são distintos,
 e para cada horário, os medicamentos são distintos e são ordenados lexicograficamente.

 Defina as funções "receituarioValido" e "planoValido" que verifiquem as propriedades acima e cujos tipos são dados abaixo:

 receituarioValido :: Receituario -> Bool
 planoValido :: PlanoMedicamento -> Bool
 -}

isOrdered :: Ord a => [a] -> Bool
isOrdered [] = True
isOrdered [x] = True
isOrdered (x:y:xs) = x < y && isOrdered (y:xs)

receituarioValido :: Receituario -> Bool
receituarioValido rec = isOrdered names && all isOrdered times
  where names = map fst rec
        times = map snd rec

planoValido :: PlanoMedicamento -> Bool
planoValido plan = isOrdered times && all isOrdered meds
  where times = map fst plan
        meds = map snd plan
{-

   QUESTÃO 6  VALOR: 1,0 ponto,

 Um plantão é válido se, e somente se,

 1. Os horários da lista são distintos e estão em ordem crescente;
 2. Não há, em um mesmo horário, ocorrência de compra e medicagem de um mesmo medicamento (e.g. `[Comprar m1, Medicar m1 x]`);
 3. Para cada horário, as ocorrências de Medicar estão ordenadas lexicograficamente.

 Defina a função "plantaoValido" que verifica as propriedades acima e cujo tipo é dado abaixo:

 plantaoValido :: Plantao -> Bool
 -}

plantaoValido :: Plantao -> Bool
plantaoValido p = isOrdered times && all isOrdered meds' && valid
  where times = map fst p
        cs = map snd p
        meds = map (filter medicar) cs

        compras = map (filter comprar) cs

        medicar (Medicar _) = True
        medicar _ = False

        comprar (Comprar _ _) = True
        comprar _ = False

        meds' = map (map (\(Medicar m) -> m)) meds
        compras' = map (map (\(Comprar m _) -> m)) compras

        valid = all null $ zipWith L.intersect meds' compras'

{-
  QUESTÃO 7  VALOR: 1,0 ponto

  Defina a função "geraPlanoReceituario", cujo tipo é dado abaixo e que, a partir de um receituario válido,
  retorne um plano de medicamento válido.

  Dica: enquanto o receituário lista os horários que cada remédio deve ser tomado, o plano de medicamentos  é uma
  disposição ordenada por horário de todos os remédios que devem ser tomados pelo  paciente em um certo horário.

  geraPlanoReceituario :: Receituario -> PlanoMedicamento

-}

geraPlanoReceituario :: Receituario -> PlanoMedicamento
geraPlanoReceituario = group . qsort . invert

invert :: [(a, [b])] -> [(b, a)]
invert = concatMap (\(x, ys) -> map (\y -> (y, x)) ys)

group :: Eq a => [(a, b)] -> [(a, [b])]
group [] = []
group (x:xs) = g : group ys
  where f p = fst x == fst p
        g = (fst x, snd x : map snd (takeWhile f xs))
        ys = dropWhile f xs


{- QUESTÃO 8  VALOR: 1,0 ponto

 Defina a função "geraReceituarioPlano", cujo tipo é dado abaixo e que retorna um receituário válido a partir de um
 plano de medicamentos válido.
 Dica: Existe alguma relação de simetria entre o receituário e o plano de medicamentos? Caso exista, essa simetria permite
 compararmos a função geraReceituarioPlano com a função geraPlanoReceituario ? Em outras palavras, podemos definir
 geraReceituarioPlano com base em geraPlanoReceituario ?

 geraReceituarioPlano :: PlanoMedicamento -> Receituario

-}

geraReceituarioPlano :: PlanoMedicamento -> Receituario
geraReceituarioPlano = group . qsort . invert

{-  QUESTÃO 9 VALOR: 1,0 ponto

Defina a função "executaPlantao", cujo tipo é dado abaixo e que executa um plantão válido a partir de um estoque de medicamentos,
resultando em novo estoque. A execução consiste em desempenhar, sequencialmente, todos os cuidados para cada horário do plantão.
Caso o estoque acabe antes de terminar a execução, o resultado da função deve ser Nothing. Caso contrário,
Just v, onde v é o valor final do estoque de medicamentos

executaPlantao :: Plantao -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos

-}

executaPlantao :: Plantao -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos
executaPlantao [] e = Just e
executaPlantao ((h, cs):ps) e = do
  e' <- go cs e
  executaPlantao ps e'
  where go :: [Cuidado] -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos
        go [] e = Just e
        go (c:cs) e = do
          e' <- executaCuidado c e
          go cs e'

executaCuidado :: Cuidado -> EstoqueMedicamentos -> Maybe EstoqueMedicamentos
executaCuidado (Comprar med qtd) e = Just $ comprarMedicamento med qtd e
executaCuidado (Medicar med) e = tomarMedicamento med e

{-
QUESTÃO 10 VALOR: 1,0 ponto

Defina uma função "satisfaz", cujo tipo é dado abaixo e que verifica se um plantão é válido e satisfaz um plano de medicamento para um certo estoque, ou seja,
a função "satisfaz" deve verificar se a execução do plantão implica terminar com estoque diferente de Nothing e
administrar os medicamentos prescritos no plano.
Dica: fazer correspondencia entre os remédios previstos no plano e os ministrados pela execução do plantão.
Note que alguns cuidados podem ser comprar medicamento e que eles podem ocorrer sozinhos em certo horário ou
juntamente com ministrar medicamento.

satisfaz :: Plantao -> PlanoMedicamento -> EstoqueMedicamentos  -> Bool

-}

satisfaz :: Plantao -> PlanoMedicamento -> EstoqueMedicamentos  -> Bool
satisfaz ps plan e = plantaoValido ps && plantao2plano ps == plan && executaPlantao ps e /= Nothing

plantao2plano :: Plantao -> PlanoMedicamento
plantao2plano [] = []
plantao2plano p = filter (not . null . snd) $ map f p
  where f (h, cs) = (h, qsort $ g cs)
        g [] = []
        g ((Medicar m):cs) = m : g cs
        g ((Comprar _ _):cs) = g cs

{-

QUESTÃO 11 (EXTRA) VALOR: 1,0 ponto

 Defina a função "plantaoCorreto", cujo tipo é dado abaixo e que gera um plantão valido que satisfaz um plano de
 medicamentos e um estoque de medicamentos.
 Dica: a execução do plantão deve atender ao plano de medicamentos e ao estoque.

 plantaoCorreto :: PlanoMedicamento ->  EstoqueMedicamentos  -> Plantao

-}

horarioBase :: PlanoMedicamento -> Horario
horarioBase ((h,_):_) = h - 1

plantaoCorreto :: PlanoMedicamento ->  EstoqueMedicamentos  -> Plantao
plantaoCorreto plano e = cuidadoCompras : plano2plantao plano
  where estoqueNecessario = obterMedicamentos plano
        dif = diferencaEstoque estoqueNecessario e
        compras = map (uncurry Comprar) dif
        cuidadoCompras = (h, compras)
        h = horarioBase plano

plano2plantao :: PlanoMedicamento -> Plantao
plano2plantao = map (\(h, ms) -> (h, map Medicar ms))

obterMedicamentos :: PlanoMedicamento -> EstoqueMedicamentos
obterMedicamentos plano = map (\(m, xs) -> (m, length xs))
                        . group $ zip (qsort $ concatMap snd plano) (repeat 1)

diferencaEstoque :: EstoqueMedicamentos -> EstoqueMedicamentos -> EstoqueMedicamentos
diferencaEstoque e1 e2 = filter (\(m, q) -> q /= 0) $ map (`quantidadeNecessaria` e2) e1

quantidadeNecessaria :: (Medicamento, Quantidade) -> EstoqueMedicamentos -> (Medicamento, Quantidade)
quantidadeNecessaria (m, q) e = let q' = consultarMedicamento m e
  in if q' < q
     then (m, q - q')
     else (m, 0)

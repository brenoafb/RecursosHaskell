module ModeloDados where

type Medicamento = String
type Quantidade = Int
type Horario = Int
type EstoqueMedicamentos = [(Medicamento,Quantidade)]
type Prescricao = (Medicamento,[Horario])
type Receituario = [Prescricao]
type PlanoMedicamento = [(Horario,[Medicamento])]
type Plantao = [(Horario,[Cuidado])]
data Cuidado = Comprar Medicamento Quantidade |
               Medicar Medicamento


instance Show Cuidado where
 show (Comprar m q) = "Comprar " ++ Prelude.show q ++ " comprimido(s) do medicamento: " ++ m
 show (Medicar m) = "Ministrar medicamento: " ++ m


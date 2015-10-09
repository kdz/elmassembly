import Array
import Basics

import Debug
pass : a
pass = Debug.crash "Not Implemented"


---- Program Representation -----


type alias Program = List Instruction
    --{instructions: List Instruction}


type Instruction 
    = Setn Register Int -- always looks like:  Setn (R rn) v
    | Sub Register Register Register
    | Loadn Register Int
    | Storen Register Int


type Register = R Int 

i1 : Instruction
i1 = Setn (R 5) 1

p1 : Program
p1 = 
    [Setn (R 3) 10, 
     Setn (R 5) 25, 
     Sub (R 7) (R 5) (R 3), 
     Loadn (R 7) 100]

p2 : Program
p2 = [Setn (R 5) 10, Sub (R 5) (R 3) (R 2)]



---- Program Execution -----

type alias RegArray = Array.Array Int

type alias RAM = Array.Array Int

type alias MemoryState = (RegArray, RAM)

execInstruc : Instruction -> MemoryState -> MemoryState
execInstruc i m =
    case i of -- Setn (R rn) v
        Setn (R n) v -> pass --some_new_mem_state m n v
        Sub (R n1) (R n2) (R n3) -> pass --new_mem_state n1 n2 n3 m

main = Basics.toString p1

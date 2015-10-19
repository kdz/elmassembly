module Program where 

import Array
import Basics
import Html as H
import Html.Attributes as HA

import Debug


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

--execInstruc : Instruction -> MemoryState -> MemoryState
--execInstruc i m =
    --case i of -- Setn (R rn) v
        --Setn (R n) v -> pass --some_new_mem_state m n v
        --Sub (R n1) (R n2) (R n3) -> pass --new_mem_state n1 n2 n3 m

------ View --------
{-
    <table>
        <thead>
            <tr>
                <td>...</td>
                <td>...</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>instr-1</td>
            </tr>
                <td>instr-2</td>
            </tr>
        </tbody>
    </table>
-}

indexedInstrucToHtml : Int -> Instruction -> H.Html
indexedInstrucToHtml i instr = 
    H.tr [] 
        [ H.td [] [i |> toString |> H.text],
          H.td [] [instr |> toString |> H.text]]


type alias Model = Program

view : Model -> H.Html
view model =
  let 
    tableList = List.indexedMap indexedInstrucToHtml model
    headers = H.thead [] 
                [ H.tr [] 
                  [ H.td [] [ H.text "Addr"], 
                    H.td [] [ H.text "Instruction"]]]
  in
  H.div [] 
    [ H.h1 [] [H.text "Assembly Language Simulator in Elm"],
      H.text "Simulator for ", 
      H.a [HA.href "https://www.cs.hmc.edu/~cs5grad/cs5/hmmm/documentation/documentation.html"] [H.text "The Harvey Mudd Miniature Machine."],

      H.h2 [] [H.text "Work in progress: represent instructions, represent RAM and registers, interpret instructions, ..."],

      H.node "link" [HA.rel "stylesheet", HA.href "http://yui.yahooapis.com/pure/0.6.0/pure-min.css"] [],

      H.node "link" [HA.rel "stylesheet", HA.href "../css/style.css"] [],
      
      H.table [HA.class "pure-table", HA.id "assemblytable"] 
        (headers :: tableList)
    ]


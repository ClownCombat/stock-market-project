module RandomNumbers.Types exposing (..)

import Random.Pcg as Random exposing (Seed)


type alias Model =
    { range : Int
    , nextSeed : Seed
    , numbers : List Int
    , rolledNumbers : Int
    , numbersCount : List Int
    }


type Msg
    = InitSeed Int
    | Reset
    | SetRandomNumberAmount String
    | GenerateNumbers
    | GenerateNumbersWithShuffle

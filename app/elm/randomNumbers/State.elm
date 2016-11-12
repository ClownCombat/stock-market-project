module RandomNumbers.State exposing (init, update, subscriptions)

import RandomNumbers.Types exposing (..)
import Array exposing (..)
import String exposing (toInt)
import Debug exposing (..)
import Random.Pcg as Random exposing (..)


-- INIT
-- 227852861


init : ( Model, Cmd Msg )
init =
    ( Model amountRandomNumbers initSeed initNumbers initCount (initCountList amountRandomNumbers), Random.generate InitSeed (int 0 maxInt) )


amountRandomNumbers : Int
amountRandomNumbers =
    8


initSeed : Seed
initSeed =
    Random.initialSeed 227852861


initNumbers : List Int
initNumbers =
    []


initCount : Int
initCount =
    0


initCountList : Int -> List Int
initCountList times =
    List.repeat times 0



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InitSeed randomInt ->
            ( { model | nextSeed = initialSeed randomInt }, Cmd.none )

        Reset ->
            ( { model
                | numbers = []
                , rolledNumbers = 0
                , numbersCount = initCountList model.range
              }
            , Cmd.none
            )

        SetRandomNumberAmount input ->
            let
                result =
                    String.toInt input
            in
                case result of
                    Ok int ->
                        update Reset { model | range = int }

                    Err str ->
                        ( model, Cmd.none )

        GenerateNumbers ->
            let
                amount : Int
                amount =
                    model.range * 10

                ( numbers, seed ) =
                    getNumbers amount model.range model.nextSeed

                countingList : List Int
                countingList =
                    Array.initialize model.range (getCount numbers)
                        |> Array.toList

                numbersCount : List Int
                numbersCount =
                    List.map2 (+) countingList model.numbersCount
            in
                ( { model
                    | numbers = numbers
                    , nextSeed = seed
                    , rolledNumbers = model.rolledNumbers + amount
                    , numbersCount = numbersCount
                  }
                , Cmd.none
                )

        GenerateNumbersWithShuffle ->
            let
                amount : Int
                amount =
                    model.range * 10

                initArray : Array Int
                initArray =
                    Array.initialize model.range (\x -> x)

                emptyArray : Array Int
                emptyArray =
                    Array.repeat amount -1

                logOne =
                    Debug.log "array before 'drawing': " emptyArray

                ( newSeed, numbers ) =
                    getShuffleNumbersList amount ( model.nextSeed, initArray ) emptyArray

                logTwo =
                    Debug.log "array after 'drawing': " numbers

                numbersAsList =
                    toList numbers

                countingList : List Int
                countingList =
                    Array.initialize model.range (getCount numbersAsList)
                        |> Array.toList

                numbersCount : List Int
                numbersCount =
                    List.map2 (+) countingList model.numbersCount
            in
                ( { model
                    | numbers = numbersAsList
                    , nextSeed = newSeed
                    , rolledNumbers = model.rolledNumbers + amount
                    , numbersCount = numbersCount
                  }
                , Cmd.none
                )



-- Better Balancing: Switching between random and shuffled 'Draw' every three rounds!
-- GENERATORS


getGenerator : Int -> Int -> Generator (List Int)
getGenerator length range =
    Random.list length (Random.int 0 (range - 1))


getShuffleNumbersList : Int -> ( Seed, Array Int ) -> Array Int -> ( Seed, Array Int )
getShuffleNumbersList length ( seed, array ) accArray =
    let
        ( nextSeed, shuffled ) =
            shuffleArray length ( seed, array )

        afterShuffleLog =
            Debug.log "after Shuffle: " shuffled

        firstItem =
            get 0 shuffled

        drawnLog =
            Debug.log "drawn: " firstItem
    in
        if length > 0 then
            let
                newAccArray =
                    setElementInArray (length - 1) firstItem accArray

                newAcc =
                    Debug.log ("accArray in round: " ++ toString (length - 1)) newAccArray
            in
                getShuffleNumbersList (length - 1) ( nextSeed, shuffled ) newAccArray
        else
            ( nextSeed, accArray )


shuffleArray : Int -> ( Seed, Array a ) -> ( Seed, Array a )
shuffleArray length ( seed, array ) =
    let
        ( randomIndex, nextSeed ) =
            step (int 0 length) seed

        tempItem =
            get (length - 1) array

        itemAtRandomIndex =
            get randomIndex array

        arrTemp =
            setElementInArray (length - 1) itemAtRandomIndex array

        newArr =
            setElementInArray randomIndex tempItem arrTemp
    in
        if (length == 0) then
            ( seed, newArr )
        else
            shuffleArray (length - 1) ( nextSeed, newArr )


setElementInArray : Int -> Maybe a -> Array a -> Array a
setElementInArray index item arr =
    case item of
        Nothing ->
            arr

        Just e ->
            set index e arr


getCount : List Int -> Int -> Int
getCount numbers number =
    List.filter (\x -> x == number) numbers
        |> List.length


getNumbers : Int -> Int -> Seed -> ( List Int, Seed )
getNumbers length range seed =
    let
        generator =
            getGenerator length range
    in
        step generator seed



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

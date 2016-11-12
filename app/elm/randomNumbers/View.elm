module RandomNumbers.View exposing (rootView)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import RandomNumbers.Types exposing (..)
import Array exposing (..)
import Round exposing (..)


rootView : Model -> Html Msg
rootView model =
    let
        length =
            List.length model.numbersCount

        list =
            [0..length]
    in
        div []
            [ div []
                [ p [] [ text "random Number Range: " ]
                , input [ onInput SetRandomNumberAmount ] []
                ]
            , button [ onClick Reset ] [ text "Reset" ]
            , br [] []
            , button [ onClick GenerateNumbersWithShuffle ] [ text "generate Random Numbers with Shuffle" ]
            , button [ onClick GenerateNumbers ] [ text "generate Random Numbers" ]
            , div [] [ text (toString model.numbers) ]
            , div []
                [ text "Probabilities: "
                , br [] []
                , text ("rolledNumbers: " ++ toString model.rolledNumbers)
                , br [] []
                , text ("number_counts: " ++ toString model.numbersCount)
                , div [] (showNumberCounts length model.numbersCount model.rolledNumbers)
                ]
            ]


showNumberCounts : Int -> List Int -> Int -> List (Html Msg)
showNumberCounts length numbersCount rolledNumbers =
    if (length > 1) then
        showNumberCount (length - 1) numbersCount rolledNumbers :: showNumberCounts (length - 1) numbersCount rolledNumbers
    else
        [ showNumberCount 0 numbersCount rolledNumbers ]


showNumberCount : Int -> List Int -> Int -> Html Msg
showNumberCount index numbersCount rolledNumbers =
    let
        arrNumbers =
            fromList numbersCount

        number =
            get index arrNumbers
    in
        case number of
            Nothing ->
                text ("no")

            Just n ->
                div []
                    [ br [] []
                    , text (toString index ++ " -> : " ++ toString (Round.round 2 ((toFloat n) / (toFloat rolledNumbers))))
                    ]

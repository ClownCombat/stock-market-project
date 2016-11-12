module SimpleComponent.Edit.View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import SimpleComponent.Edit.Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ text "Player X: "
        , button [ onClick Decrement ] [ text "-" ]
        , text ("Level: " ++ toString model.level)
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick (Done model) ] [ text "done" ]
        ]

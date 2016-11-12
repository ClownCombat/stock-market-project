module SimpleComponent.Overview.View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import SimpleComponent.Overview.Types exposing (..)
import SimpleComponent.Player.Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ text "overview content - displaying some player information"
        , div [] (List.map showPlayer model)
        ]


showPlayer : Player -> Html Msg
showPlayer player =
    div []
        [ text ("Level: " ++ toString player.level ++ ", Health: " ++ toString player.health ++ ", Power: " ++ toString player.power ++ " ")
        , button [ onClick (None player) ] [ text "edit" ]
        ]

module SimpleComponent.Overview.State exposing (init, update, subscriptions)

import SimpleComponent.Player.Types exposing (Player)
import SimpleComponent.Overview.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialPlayers, Cmd.none )


initialPlayers : List Player
initialPlayers =
    Player 1 22 12 0 :: Player 1 28 7 1 :: Player 1 17 5 2 :: Player 2 33 14 3 :: []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

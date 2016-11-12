module SimpleComponent.Edit.State exposing (init, update, subscriptions)

import SimpleComponent.Player.Types exposing (Player)
import SimpleComponent.Player.State exposing (..)
import SimpleComponent.Edit.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Player 0 0 0 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        justModel =
            ( model, Cmd.none )
    in
        case msg of
            Done player ->
                justModel

            Increment ->
                ( increaseLevel model, Cmd.none )

            Decrement ->
                ( decreaseLevel model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

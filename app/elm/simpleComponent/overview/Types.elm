module SimpleComponent.Overview.Types exposing (..)

import SimpleComponent.Player.Types exposing (..)


type alias Model =
    List Player


type Msg
    = None Player

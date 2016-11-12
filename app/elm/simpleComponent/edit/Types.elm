module SimpleComponent.Edit.Types exposing (..)

import SimpleComponent.Player.Types exposing (..)


type alias Model =
    Player


type Msg
    = Done Player
    | Increment
    | Decrement

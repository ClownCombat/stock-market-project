module Main exposing (main)

import Html.App as App
import RandomNumbers.State as State
import RandomNumbers.View as View


main : Program Never
main =
    App.program
        { init = State.init
        , update = State.update
        , view = View.rootView
        , subscriptions = State.subscriptions
        }

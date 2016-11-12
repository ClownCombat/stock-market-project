module SimpleComponent.Types exposing (..)

import SimpleComponent.Overview.Types as Overview
import SimpleComponent.Edit.Types as Edit


type alias Model =
    { overviewModel : Overview.Model
    , editModel : Edit.Model
    , display : Display
    , index : Int
    }


type Msg
    = OverviewMsg Overview.Msg
    | EditMsg Edit.Msg
    | ChangeView


type Display
    = Overview
    | Edit

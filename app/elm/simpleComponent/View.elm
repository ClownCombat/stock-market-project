module SimpleComponent.View exposing (rootView)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (onClick)
import SimpleComponent.Types exposing (..)
import SimpleComponent.Overview.View as Overview exposing (view)
import SimpleComponent.Edit.View as Edit exposing (view)


rootView : Model -> Html Msg
rootView model =
    div []
        [ button [ onClick ChangeView ] [ text "changeView" ]
        , showView model
        ]


showView : Model -> Html Msg
showView model =
    case model.display of
        Overview ->
            div [] [ App.map OverviewMsg (Overview.view model.overviewModel) ]

        Edit ->
            div [] [ App.map EditMsg (Edit.view model.editModel) ]

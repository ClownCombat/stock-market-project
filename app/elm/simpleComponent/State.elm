module SimpleComponent.State exposing (init, update, subscriptions)

import SimpleComponent.Types exposing (..)
import SimpleComponent.Overview.State as Overview exposing (init)
import SimpleComponent.Edit.State as Edit exposing (init)
import SimpleComponent.Edit.Types as EditTypes
import SimpleComponent.Overview.Types as OverviewTypes
import Array


init : ( Model, Cmd Msg )
init =
    ( Model (fst Overview.init) (fst Edit.init) Overview -1, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        justModel =
            ( model, Cmd.none )
    in
        case msg of
            OverviewMsg viewMsg ->
                case viewMsg of
                    OverviewTypes.None player ->
                        ( { model | display = Edit, editModel = player }, Cmd.none )

            EditMsg viewMsg ->
                case viewMsg of
                    EditTypes.Done player ->
                        let
                            arr =
                                Array.fromList model.overviewModel

                            newPlayers =
                                Array.set player.index player arr
                                    |> Array.toList
                        in
                            ( { model | display = Overview, overviewModel = newPlayers }, Cmd.none )

                    _ ->
                        let
                            ( x, y ) =
                                Edit.update viewMsg model.editModel
                        in
                            ( { model | editModel = x }, Cmd.none )

            ChangeView ->
                case model.display of
                    Overview ->
                        ( { model | display = Edit }, Cmd.none )

                    Edit ->
                        ( { model | display = Overview }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

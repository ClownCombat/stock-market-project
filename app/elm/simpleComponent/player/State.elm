module SimpleComponent.Player.State exposing (..)

import SimpleComponent.Player.Types exposing (..)


increaseLevel : Player -> Player
increaseLevel player =
    let
        level =
            player.level + 1

        health =
            player.health + 6 + (player.health // 10)

        power =
            player.power + 3
    in
        Player level health power player.index


decreaseLevel : Player -> Player
decreaseLevel player =
    let
        level =
            player.level - 1

        health =
            player.health - 6 - ((player.health - 6) // 10)

        power =
            player.power - 3
    in
        Player level health power player.index

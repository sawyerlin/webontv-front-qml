import QtQuick 2.2

Item {
    property int positionX: 0
    property int positionY: 0

    clip: true
    width: 46
    height: 44
    Image {
        fillMode: Image.Tile
        source: "../../../images/mediaItem/player_sprite.png"
        x: positionX
        y: positionY
    }
}

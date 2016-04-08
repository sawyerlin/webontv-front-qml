import QtQuick 2.2

Item {
    property int positionX: 0
    property string name: ""

    signal shown()
    signal hidden()
    signal pressed()

    width: 46
    height: 44
    Item {
        id: textItem
        visible: false
        anchors.bottom: imageItem.top
        anchors.bottomMargin: 8
        Rectangle {
            id: rectItem
            color: "white"
            width: 1
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.bottom: parent.bottom
        }
    }
    Item {
        id: imageItem
        clip: true
        width: parent.width
        height: parent.height 
        Image {
            id: image
            fillMode: Image.Tile
            source: "../../../../images/mediaItem/player_sprite.png"
            x: positionX
        }
    }
    Keys.onPressed: {
        if (event.key == Qt.Key_Return) {
            pressed();
        }
    }
    function show() {
        focus = true;
        image.y = -44;
        textItem.visible = true;
        shown();
    }
    function hide() {
        focus = false;
        image.y = 0;
        textItem.visible = false;
        hidden();
    }
}

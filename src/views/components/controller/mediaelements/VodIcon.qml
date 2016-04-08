import QtQuick 2.2

Icon {
    positionX: -430
    Item {
        id: textItem
        visible: false
        anchors.top: parent.top
        anchors.topMargin: -50
        anchors.left: parent.left
        anchors.leftMargin: -30
        Text {
            id: text
            text: "plus de vidéos"
            color: "white"
            font.pixelSize: 15
            font.bold: true
        }
    }
    onShown: textItem.visible = true
    onHidden: textItem.visible = false
}

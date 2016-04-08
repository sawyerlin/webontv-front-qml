import QtQuick 2.2

Icon {
    anchors.rightMargin: 8
    positionX: -377
    Item {
        id: textItem
        visible: false
        anchors.top: parent.top
        anchors.topMargin: -50
        anchors.left: parent.left
        anchors.leftMargin: -30
        Text {
            text: "retour à"
            color: "white"
            font.pixelSize: 15
            font.bold: true
            anchors.bottom: text.top
            anchors.left: parent.left
            anchors.leftMargin: 15
        }
        Text {
            id: text
            text: "la mosaïque"
            color: "white"
            font.pixelSize: 15
            font.bold: true
        }
    }
    onShown: textItem.visible = true
    onHidden: textItem.visible = false
}

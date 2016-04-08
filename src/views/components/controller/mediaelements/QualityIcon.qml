import QtQuick 2.2

Icon {
    anchors.rightMargin: 8
    positionX: -323
    Column {
        id: textItem
        visible: false
        anchors.top: parent.top
        anchors.topMargin: -70
        anchors.left: parent.left
        Row {
            QualityType {
                model: 5
            }
            Rectangle {
                width: 10
                height: 15
                color: "transparent"
            }
            Text {
                text: "HD"
                color: "white"
                font.pixelSize: 15
                font.bold: true
                anchors.leftMargin: 20
            }
        }
        Row {
            QualityType {
                model: 3
            }
            Rectangle {
                width: 20
                height: 15
                color: "transparent"
            }
            Text {
                text: "SD"
                color: "white"
                font.pixelSize: 15
                font.bold: true
                anchors.leftMargin: 20
            }
        }
    }
    onShown: textItem.visible = true
    onHidden: textItem.visible = false
}

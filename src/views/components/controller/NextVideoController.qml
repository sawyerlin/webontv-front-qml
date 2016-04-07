import QtQuick 2.2

Item {
    property alias imageSource: videoNextImage.source
    property alias name: videoNextName.text
    property string borderColor: "transparent"

    Item {
        anchors.fill: parent
        anchors.leftMargin: 45
        anchors.rightMargin: 45
        anchors.bottomMargin: 10
        clip: true
        Rectangle {
            id: imageRect
            anchors.fill: parent
            border.width: 5
            border.color: borderColor
            color: "transparent"
            anchors.bottomMargin: 45
            Image {
                id: videoNextImage
                anchors.fill: parent
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
            }
        }
        Text {
            id: videoNextText
            anchors.top: imageRect.bottom
            text: "vidéo suivante"
            font.bold: true
            color: "white"
        }
        Text {
            id: videoNextName
            anchors.top: videoNextText.bottom
            font.pixelSize: 25
            font.bold: true
            color: "white"
            wrapMode: Text.WordWrap
        }
    }
}

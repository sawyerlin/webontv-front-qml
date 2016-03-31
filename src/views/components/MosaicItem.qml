import QtQuick 2.2

Rectangle {
    property alias name: name.text
    property alias type: type.text
    property alias background: image.source
    width: 352
    height: 182
    Image {
        id: image
        fillMode: Image.PreserveAspectFit
        cache: true
        width: 352
        height: 182
        Rectangle {
            color: "black"
            opacity: 0.8
            width: 352
            height: 65
            anchors.horizontalCenter: image.horizontalCenter
            anchors.bottom: image.bottom
            Text {
                id: name 
                color: "white"
                font.bold: true
                font.pixelSize: 20
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
            }
            Text {
                id: type
                color: "white"
                font.bold: true
                font.pixelSize: 13
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: name.bottom
                anchors.topMargin: 5
            }
        }
    }
}

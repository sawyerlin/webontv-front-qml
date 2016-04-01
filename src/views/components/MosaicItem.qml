import QtQuick 2.2

Rectangle {
    property string name: ""
    property string type: ""
    property int margin: 0
    property alias background: image.source
    property int innerWidth: 0
    property int innerHeight: 0
    Image {
        id: image
        fillMode: Image.Stratch
        cache: true
        anchors.left: parent.left
        anchors.leftMargin: margin
        anchors.top: parent.top
        anchors.topMargin: margin
        height: innerHeight
        width: innerWidth
        Rectangle {
            color: "black"
            opacity: 0.8
            width: innerWidth
            height: 65
            anchors.horizontalCenter: image.horizontalCenter
            anchors.bottom: image.bottom
            Text {
                text: name
                color: "white"
                font.bold: true
                font.pixelSize: 20
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
            }
            Text {
                text: type
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

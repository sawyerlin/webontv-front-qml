import QtQuick 2.2

Item {
    property alias background: background.source
    property alias logo: logoVod.source
    property alias name: channelName.text
    property alias desc: channelDesc.text
    Image {
        id: background
        anchors.fill: parent
    }
    Item {
        anchors.left: parent.left
        anchors.leftMargin: 110
        anchors.top: parent.top
        anchors.topMargin: 50
        Image {
            id: logoVod
            anchors.left: parent.left
            anchors.top: parent.top
            width: 162
            height: 89
        }
        Text {
            id: channelName
            anchors.left: logoVod.right
            anchors.leftMargin: 50
            font.pixelSize: 38
            color: "white"
        }
        Text {
            id: channelDesc
            anchors.left: logoVod.right
            anchors.leftMargin: 50
            anchors.top: channelName.bottom
            anchors.topMargin: 10
            font.pixelSize: 21
            color: "white"
        }
    }
}

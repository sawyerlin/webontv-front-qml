import QtQuick 2.2

Item {
    property int itemWidth: 257
    property int itemMargin: 10
    property var itemSource: undefined
    property string backgroundColor: "transparent"
    property alias backgroundFillMode: image.fillMode
    property int backgroundPositionX: 0
    property int backgroundPositionY: 0

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: itemWidth + itemMargin
    Rectangle {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: itemMargin
        color: "transparent"
    }
    Rectangle {
        color: backgroundColor
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: itemWidth
        Image {
            id: image
            anchors.top: parent.top 
            anchors.bottom: itemSource ? parent.bottom: undefined
            anchors.left: parent.left
            anchors.right: itemSource ? parent.right: undefined
            anchors.leftMargin: backgroundPositionX
            anchors.topMargin: backgroundPositionY
            source: itemSource ? itemSource.background : "../../images/underline_grey.png"
        }
        Text {
            visible: !itemSource 
            text: "tout afficher"
            font.pixelSize: 18
            color: "#3c3c3c"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: backgroundPositionX - 15
            anchors.topMargin: backgroundPositionY - 25
        }
    }
}

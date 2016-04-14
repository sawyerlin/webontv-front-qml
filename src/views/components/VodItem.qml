import QtQuick 2.2

Item {
    property var itemSource: undefined
    property bool isTrueItem: itemSource.index != "-1"
    property int itemWidth: isTrueItem ? 257 : 143
    property int itemMargin: 10
    property string backgroundColor: isTrueItem ? "transparent" : "#cccccc"
    property string backgroundImage: isTrueItem ? itemSource.background : "../../images/underline_grey.png"
    property int backgroundPositionX: isTrueItem ? 0 : 34
    property int backgroundPositionY: isTrueItem ? 0 : 130

    signal moveLeft(int index);
    signal moveRight(int index);
    signal moveUp(int index);
    signal moveDown(int index);

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
            anchors.bottom: isTrueItem ? parent.bottom : undefined
            anchors.left: parent.left
            anchors.right: isTrueItem ? parent.right : undefined
            anchors.leftMargin: backgroundPositionX
            anchors.topMargin: backgroundPositionY
            source: backgroundImage
        }
        Text {
            visible: !isTrueItem
            text: "tout afficher"
            font.pixelSize: 18
            color: "#3c3c3c"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: backgroundPositionX - 15
            anchors.topMargin: backgroundPositionY - 25
        }
    }
    Keys.onPressed: {
        switch (event.key) {
            case Qt.Key_Left:
            moveLeft(itemSource.index);
            break;
            case Qt.Key_Right:
            moveRight(itemSource.index);
            break;
            case Qt.Key_Up:
            moveUp(itemSource.index);
            break;
            case Qt.Key_Down:
            moveDown(itemSource.index);
            break;
        }
    }
}

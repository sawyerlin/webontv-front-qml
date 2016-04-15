import QtQuick 2.2

Item {
    property var itemSource: undefined
    property bool isFirstItem: itemSource.index == 0
    property int itemWidth: !isFirstItem ? 257 : 143
    property int itemMargin: 20
    property int totalWidth: itemWidth + itemMargin
    property string backgroundColor: !isFirstItem ? "transparent" : (focus ? "#ff6600" : "#cccccc")
    property string backgroundImage: !isFirstItem ? itemSource.background : "../../images/underline_grey.png"
    property int backgroundPositionX: !isFirstItem ? 0 : 34
    property int backgroundPositionY: !isFirstItem ? 0 : 130

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
            anchors.bottom: !isFirstItem ? parent.bottom : undefined
            anchors.left: parent.left
            anchors.right: !isFirstItem ? parent.right : undefined
            anchors.leftMargin: backgroundPositionX
            anchors.topMargin: backgroundPositionY
            source: backgroundImage
        }
        Text {
            visible: isFirstItem
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

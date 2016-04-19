import QtQuick 2.2

import "../../utils"

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

    signal moveLeft(int index)
    signal moveRight(int index)
    signal moveUp(int index)
    signal moveDown(int index)
    signal enter(var id)

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: itemWidth + itemMargin
    Utils {id: utils}
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
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 18
            color: "#3c3c3c"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: backgroundPositionX
            anchors.topMargin: backgroundPositionY - 55
            width: 80
        }
        Rectangle {
            visible: !isFirstItem
            anchors.bottom: info.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 20
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#00000000"}
                GradientStop {position: 1.2; color: "#FF000000"}
            }
        }
        Rectangle {
            id: info
            visible: !isFirstItem
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 65
            color: "black"
            Item {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                Text {
                    id: title
                    color: "white"
                    font.bold: true
                    font.pixelSize: 20
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    text: itemSource.title || ""
                    elide: Text.ElideRight
                }
                Text {
                    color: "white"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.left: parent.left
                    anchors.top: title.bottom
                    anchors.topMargin: 5
                    text: "il y a " + utils.getDays(itemSource.startDate) + " jours(s)"
                }
                Text {
                    color: "white"
                    font.bold: true
                    font.pixelSize: 15
                    anchors.right: parent.right
                    anchors.top: title.bottom
                    anchors.topMargin: 5
                    text: utils.timeToHHMMSS(itemSource.duration)
                }
            }
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
            case Qt.Key_Return:
            enter(isFirstItem ? undefined : itemSource.id);
            break;
        }
    }
}

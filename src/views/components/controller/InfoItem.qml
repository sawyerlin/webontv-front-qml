import QtQuick 2.2

import "mediaelements"

Item {
    property alias logoSource: logo.source
    property alias channelName: channelName.text
    property alias programName: programName.text

    Image {
        id: logo
        width: 85
        height: 63
    }
    Item {
        anchors.left: logo.right
        anchors.leftMargin: 15
        Text {
            id: channelName
            font.pixelSize: 25
            font.bold: true
            color: "white"
        }
        Text {
            id: programName
            anchors.top: channelName.bottom
            anchors.topMargin: 5
            font.pixelSize: 25
            font.bold: true
            color: "white"
        }
    }
    Item {
        anchors.right: parent.right
        width: 50
        Icon {
            id: iconvod
            positionX: -430
        }
        Icon {
            id: iconquality
            anchors.right: iconvod.left
            anchors.rightMargin: 8
            positionX: -323
        }
        Icon {
            id: iconplayback
            anchors.right: iconquality.left
            anchors.rightMargin: 8
            positionX: -107
        }
        Icon {
            id: iconreturn
            anchors.right: iconplayback.left
            anchors.rightMargin: 8
            positionX: -377
            positionY: -44
        }
    }
    function updatePlayback(pause) {
        if (pause) {
            iconplayback.positionX = -161;
        } else {
            iconplayback.positionX = -107;
        }
    }
    function moveRight(index) {
        switch(index) {
            case 0:
            iconreturn.positionY = 0;
            iconplayback.positionY = -44;
            break;
            case 1:
            iconplayback.positionY = 0;
            iconquality.positionY= -44;
            break;
            case 2:
            iconquality.positionY= 0;
            iconvod.positionY= -44;
            break;
            case 3:
            videoNext.borderColor = "white";
            iconvod.positionY = 0;
            break;
        }
    }
    function moveLeft(index) {
        switch(index) {
            case 1:
            iconreturn.positionY = -44;
            iconplayback.positionY = 0;
            break;
            case 2:
            iconplayback.positionY = -44;
            iconquality.positionY = 0;
            break;
            case 3:
            iconquality.positionY = -44;
            iconvod.positionY = 0;
            break;
            case 4:
            videoNext.borderColor = "transparent";
            iconvod.positionY = -44;
            break;
        }
    }
}

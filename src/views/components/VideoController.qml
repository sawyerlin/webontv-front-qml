import QtQuick 2.2

import "controller"
import "mediaelements"

Item {
    property int currentIndex: 0
    property alias duration: timeline.duration
    property string imageServerPath: undefined 
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 255
    Rectangle {
        anchors.fill: parent;
        color: "black"
        opacity: 0.7
    }
    NextVideoController {
        id: videoNext
        anchors.left: infoItem.right
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
    Item {
        id: infoItem
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 300
        height: 63
        Image {
            id: logo
            width: 85
            height: 63
        }
        Item {
            anchors.left: logo.right
            anchors.leftMargin: 15
            Text {
                id: chanelName
                font.pixelSize: 25
                font.bold: true
                color: "white"
            }
            Text {
                id: programName
                anchors.top: chanelName.bottom
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
    }
    Timeline {
        id: timeline
        anchors.top: infoItem.bottom
        anchors.topMargin: 40
        anchors.left: infoItem.left
        anchors.right: infoItem.right
    }
    function init(data) {
        //duration.text = timeFromMS(ms);
        logo.source = data.logo;
        chanelName.text = data.chanelName;
        programName.text = data.program.name;
        videoNext.imageSource = data.nextProgram.imageSource;
        videoNext.name = data.nextProgram.text;
    }
    function move(key) {
        switch (key) {
            case Qt.Key_Right:
            switch(currentIndex) {
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
                imageRect.color = "white";
                imageRect.border.color = "white";
                iconvod.positionY = 0;
                break;
            }
            if (currentIndex < 4) {
                currentIndex ++;
            }
            break;
            case Qt.Key_Left:
            switch(currentIndex) {
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
                imageRect.color = "transparent";
                imageRect.border.color = "transparent";
                iconvod.positionY = -44;
                break;
            }
            if (currentIndex > 0) {
                currentIndex --;
            }
            break;
        }
    }
    function updatePlayback(pause) {
        if (pause) {
            iconplayback.positionX = -161;
        } else {
            iconplayback.positionX = -107;
        }
    }
    function updateCurrentPosition(position) {
        timeline.positionTime = position;
        timeline.position = Math.floor(position / duration * timeline.width);
    }
}

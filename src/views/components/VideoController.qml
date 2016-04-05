import QtQuick 2.2

import "mediaelements"

Item {
    property int currentIndex: 0
    property string imageServer: "http://fo-orange-preprod.hubee.tv/elts/"
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 255
    Rectangle {
        anchors.fill: parent;
        color: "black"
        opacity: 0.7
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
                id: chanelType
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
    Item {
        anchors.top: infoItem.bottom
        anchors.topMargin: 20
        anchors.left: infoItem.left
        anchors.right: infoItem.right
        Item {
            id: timeItem
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 25
            Text {
                id: currentPosition
                font.pixelSize: 25
                font.bold: true
                color: "white"
                text: "00:00:00"
            }
            Text {
                id: duration
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 25
                font.bold: true
                color: "white"
                text: "00:35:09"
            }
        }
        Rectangle {
            anchors.top: timeItem.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.right: parent.right
            height: 10
            color: "gray"
            Rectangle {
                id: timeline
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "white"
            }
        }
    }
    function init(chanel, ms) {
        duration.text = timeFromMS(ms);
        logo.source = imageServer + chanel.logoLiveFilepath;
        chanelName.text = chanel.name;
        chanelType.text = chanel.genre;
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
            }
            if (currentIndex < 3) {
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
                iconquality.positionY= 0;
                break;
                case 3:
                iconquality.positionY= -44;
                iconvod.positionY= 0;
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
    function updateCurrentPosition(position, duration) {
        currentPosition.text = timeFromMS(position);
        timeline.width = Math.floor(position / duration * infoItem.width);
    }
    function timeFromMS(ms) {
        var sec_num = Math.floor(ms / 1000);
        var hours = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);

        if (hours < 10) {
            hours = "0" + hours;
        }
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (seconds < 10) {
            seconds = "0" + seconds;
        }
        var time = hours + ':' + minutes + ':' + seconds;
        return time;
    }
}

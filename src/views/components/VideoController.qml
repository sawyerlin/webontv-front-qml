import QtQuick 2.2

import "controller"

Item {
    property int currentIndex: 0
    property alias duration: timeline.duration
    property bool isPaused: false

    signal pause()
    signal play()
    signal back()
    signal qualityChanged()
    signal vod()
    signal next()
    signal prevChannel()
    signal nextChannel()
    signal imageEnd()
    
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 255
    Rectangle {
        anchors.fill: parent;
        color: "black"
        opacity: 0.7
    }
    InfoItem {
        id: infoItem
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 300
        height: 63
    }
    NextVideoController {
        id: videoNext
        anchors.left: infoItem.right
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
    Timeline {
        id: timeline
        anchors.top: infoItem.bottom
        anchors.topMargin: 40
        anchors.left: infoItem.left
        anchors.right: infoItem.right
        onEnd: imageEnd()
    }
    Keys.onPressed: {
        switch (event.key) {
            case Qt.Key_Return:
            switch (videoController.currentIndex) {
                case 0:
                infoItem.updatePlayback(false);
                back();
                break;
                case 1:
                if (isPaused) {
                    play();
                } else {
                    pause();
                }
                isPaused = !isPaused;
                infoItem.updatePlayback(isPaused);
                break;
                case 2:
                qualityChanged();
                break;
                case 3:
                vod();
                break;
                case 4:
                next();
                break;
            }
            break;
            case Qt.Key_PageUp:
            nextChannel();
            break;
            case Qt.Key_PageDown:
            prevChannel();
            break;
            default:
            move(event.key);
            break;
        }
    }
    function init(data) {
        infoItem.logoSource = data.logo;
        infoItem.channelName = data.channelName;
        infoItem.programName = data.program.currentProgram.name;
        videoNext.imageSource = data.program.nextProgram.imageSource;
        videoNext.name = data.program.nextProgram.text;
    }
    function setDuration(duration) {
        timeline.setDuration(duration);
    }
    function move(key) {
        switch (key) {
            case Qt.Key_Right:
            infoItem.moveRight(currentIndex);
            if (currentIndex < 4) {
                currentIndex ++;
            }
            break;
            case Qt.Key_Left:
            infoItem.moveLeft(currentIndex);
            if (currentIndex > 0) {
                currentIndex --;
            }
            break;
        }
    }
    function updateCurrentPosition(position) {
        timeline.positionTime = position;
    }
}

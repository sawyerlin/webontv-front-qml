import QtQuick 2.2

import "controller"

Item {
    property int currentIndex: 0
    property alias duration: timeline.duration
    property int timerTime: 0
    property bool isShown: false

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
    Timer {
        id: timer
        interval: 1000
        repeat: true
        onTriggered: {
            timerTime += 1000;
            if (timerTime === 5000) {
                timerTime = 0;
                visible = false;
                timer.stop();
            }
        }
    }
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
        onBackClicked: onBack()
        onPlayBackClicked: paused ? pause() : play()
        onQualityClicked: qualityChanged()
        onVodClicked: onVod()
        onMoveOutBound: videoNext.setFocus()
    }
    NextVideoController {
        id: videoNext
        anchors.left: infoItem.right
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onMoveLeft: infoItem.setFocus()
        onLoadNext: next()
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
        if (isShown) {
            timer.start();
            timerTime = 0;
            visible = true;
            switch (event.key) {
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
            if (currentIndex < 4) {
                currentIndex ++;
            }
            break;
            case Qt.Key_Left:
            if (currentIndex > 0) {
                currentIndex --;
            }
            break;
        }
    }
    function updateCurrentPosition(position) {
        timeline.positionTime = position;
    }
    function setFocus() {
        timer.start();
        isShown = true;
        infoItem.setFocus();
    }
    function unSetFocus() {
        infoItem.unSetFocus();
    }
    function reset() {
        isShown = false;
        timer.stop();
        visible = true;
        timerTime = 0;
    }
    function onBack() {
        reset();
        back();
    }
    function onVod() {
        reset();
        vod();
    }
}

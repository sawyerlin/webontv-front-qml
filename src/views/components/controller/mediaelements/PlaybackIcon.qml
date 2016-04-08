import QtQuick 2.2

Icon {
    property bool paused: false
    property real pausedX: -161
    property real playedX: -107

    anchors.rightMargin: 8
    positionX: -107
    Item {
        id: textItem
        visible: false
        anchors.top: parent.top
        anchors.topMargin: -50
        anchors.left: parent.left
        anchors.leftMargin: -40
        Text {
            id: textOne
            text: "mettre"
            color: "white"
            font.pixelSize: 15
            font.bold: true
            anchors.bottom: textTwo.top
            anchors.left: parent.left
            anchors.leftMargin: 35
        }
        Text {
            id: textTwo
            text: "en pause"
            color: "white"
            font.pixelSize: 15
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: 25
        }
    }
    onShown: textItem.visible = true
    onHidden: textItem.visible = false
    onPressed: {
        if (paused) {
            play();
        } else {
            pause();
        }
    }
    function reset() {
       play(); 
    }
    function play() {
        textOne.text = "mettre";
        textTwo.text = "en pause";
        textOne.anchors.leftMargin = 35;
        textTwo.anchors.leftMargin = 25;
        positionX = playedX;
        paused = false;
    }
    function pause() {
        textOne.text = "en pause";
        textTwo.text = "on vous attend !";
        textOne.anchors.leftMargin = 25;
        textTwo.anchors.leftMargin = 0;
        positionX = pausedX;
        paused = true;
    }
}

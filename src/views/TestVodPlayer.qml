import QtQuick 2.2

View {
    signal back()

    Text {
        color: "black"
        font.pixelSize: 50
        anchors.fill: parent
        anchors.centerIn: parent
        text: "Vod Player View"
    }
    Keys.onPressed: {
        back();
    }
}

import QtQuick 2.2

View {
    signal back()

    anchors.fill: parent
    Text {
        text: "VodHome"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 50
    }
    Keys.onPressed: {
        back();
    }
}

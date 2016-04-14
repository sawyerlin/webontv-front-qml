import QtQuick 2.2

import "components"

View {
    property var source: undefined
    property string imageServerPath: undefined
    property var dataSource: undefined

    signal back()

    anchors.fill: parent
    VodHeader {
        id: vodHeader
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 200
    }
    Text {
        text: "VodHome"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 50
    }
    Keys.onPressed: back()
    function init(channel) {
        dataSource = channel;
        vodHeader.background = channel.banner;
        vodHeader.logo = channel.vodLogo;
        vodHeader.name = channel.channelName;
        vodHeader.desc = channel.channelDesc;
        source.getResult(channel.channelId, function(result) {
            dataSource.categories = result;
            // TODO: update view
        });
    }
}

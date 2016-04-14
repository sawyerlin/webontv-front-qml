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
    ListModel {id: vodModel}
    Item {
        anchors.fill: parent
        anchors.topMargin: 220
        anchors.leftMargin: 110
        Column {
            anchors.fill: parent
            Repeater {
                model: vodModel 
                VodLine {lineSource: model}
            }
        }
        Border {
            id: focus
            width: 100
            height: 100
            border.width: 5
            anchors.left: parent.left
            anchors.top: parent.top
        }
    }
    function init(channel) {
        dataSource = channel;
        vodHeader.background = channel.banner;
        vodHeader.logo = channel.vodLogo;
        vodHeader.name = channel.channelName;
        vodHeader.desc = channel.channelDesc;
        source.getResult(channel.channelId, function(result) {
            dataSource.categories = result;
            for (var index in dataSource.categories) {
                vodModel.append(dataSource.categories[index]);
            }
        });
    }
}

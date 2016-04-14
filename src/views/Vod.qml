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
    Column {
        anchors.fill: parent
        anchors.topMargin: 220
        anchors.leftMargin: 110
        Repeater {
            model: vodModel 
            VodLine {
                headerName: model.name + " (" + model.size + ")"
                lineSource: model.programs
            }
        }
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
            for (var index in dataSource.categories) {
                vodModel.append(dataSource.categories[index]);
            }
        });
    }
}

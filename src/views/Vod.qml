import QtQuick 2.2

import "components"

View {
    property var source: undefined
    property string imageServerPath: undefined
    property var dataSource: undefined
    property int rowIndex: 0
    property int currentLeftMargin: 0
    property int lineHeaderFontSize: 22
    property int lineHeaderMargin: 10
    property int lineHeaderHeight: lineHeaderFontSize + lineHeaderMargin * 2
    property int lineWrapperHeight: 210
    property int itemWrapperWidth: 0
    property int vodItemTopMargin: 220
    property int vodItemLeftMargin: 110

    signal back()

    id: vodHome
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
        anchors.topMargin: vodItemTopMargin
        anchors.leftMargin: vodItemLeftMargin
        Column {
            anchors.fill: parent
            Repeater {
                id: lineRepeater
                model: vodModel
                VodLine {
                    headerFontSize: lineHeaderFontSize
                    headerMargin: lineHeaderMargin
                    headerHeight: lineHeaderHeight
                    wrapperHeight: lineWrapperHeight
                    lineSource: model
                    onMoveHorizontal: {
                        currentLeftMargin = this.leftMargin;
                        itemWrapperWidth = item.itemWidth;
                    }
                    onMoveVertical: {
                        var index = this.lineSource.index;
                        if (isUp) {
                            if (index > 0) {
                                var currentLine = lineRepeater.itemAt(index),
                                    previousLine = lineRepeater.itemAt(index - 1);
                                currentLine.unSetFocus();
                                previousLine.setFocus();
                                rowIndex --;
                            }
                        } else {
                            if (index + 1 < vodModel.count) {
                                var currentLine = lineRepeater.itemAt(index),
                                    nextLine = lineRepeater.itemAt(index + 1);
                                currentLine.unSetFocus();
                                nextLine.setFocus();
                                rowIndex ++;
                            }
                        }
                    }
                }
            }
        }
        Border {
            id: focus
            width: itemWrapperWidth
            height: lineWrapperHeight
            border.width: 5
            anchors.left: parent.left
            anchors.leftMargin: currentLeftMargin
            anchors.top: parent.top
            anchors.topMargin: lineHeaderHeight + rowIndex * (lineHeaderHeight + lineWrapperHeight)
            visible: currentLeftMargin == 0 ? false : true
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

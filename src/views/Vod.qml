import QtQuick 2.2

import "components"

View {
    property var source: undefined
    property var vodSource: undefined
    property var currentLine: undefined
    property int currentRow: 0
    property int vodHeaderHeight: 200
    property int headerMarginBottom: 20
    property int vodWrapperLeftMargin: 110
    property int vodWrapperTopMargin: 0
    property int vodWrapperMovingMargin: 50

    signal back()

    id: vodHome
    anchors.fill: parent
    VodHeader {
        id: vodHeader
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: vodHeaderHeight
    }
    ListModel {id: vodModel}
    Item {
        anchors.fill: parent
        anchors.topMargin: vodHeaderHeight + headerMarginBottom
        anchors.leftMargin: vodWrapperLeftMargin
        clip: true
        Column {
            anchors.fill: parent
            anchors.topMargin: vodWrapperTopMargin
            Repeater {
                id: lineRepeater
                model: vodModel
                VodLine {
                    lineSource: model
                    onMoveHorizontal: {
                        focusWrapper.width = currentLine.getCurrentItemWidth();
                    }
                    onMoveVertical: {
                        var index = parseInt(this.lineSource.index),
                            isMoved = false;
                        if (isUp) {
                            if (index > 0) {
                                currentRow --;
                                isMoved = true;
                            }
                        } else {
                            if (index + 1 < vodModel.count) {
                                currentRow ++;
                                isMoved = true;
                            }
                        }
                        if (isMoved) {
                            var nextLine = lineRepeater.itemAt(currentRow);
                            currentLine.unSetFocus();
                            nextLine.setFocus();
                            focusWrapper.width = nextLine.getCurrentItemWidth();
                            if (isUp) {
                                if ((currentRow + 1) * currentLine.totalHeight > -vodWrapperTopMargin) {
                                    vodWrapperTopMargin = 
                                    Math.min(-currentRow * currentLine.totalHeight + vodWrapperMovingMargin, 0)
                                }
                            } else {
                                if ((currentRow + 1) * currentLine.totalHeight > 
                                    vodHome.height - vodWrapperTopMargin - vodHeaderHeight - headerMarginBottom) {
                                        vodWrapperTopMargin = vodHome.height - vodHeaderHeight - headerMarginBottom -
                                        (currentRow + 1) * currentLine.totalHeight - vodWrapperMovingMargin;
                                }
                            }
                            currentLine = nextLine;
                        }
                    }
                }
            }
        }
        Border {
            id: focusWrapper
            height: currentLine ? currentLine.wrapperHeight : 0
            border.width: 5
            anchors.left: parent.left
            anchors.leftMargin: currentLine ? currentLine.leftMargin : 0
            anchors.top: parent.top
            anchors.topMargin: currentLine ? currentLine.headerHeight + currentRow* currentLine.totalHeight + vodWrapperTopMargin : 0
            visible: currentLine ? currentLine.leftMargin > 0 : false
        }
    }
    function init(channel) {
        vodSource = channel;
        vodHeader.background = channel.banner;
        vodHeader.logo = channel.vodLogo;
        vodHeader.name = channel.channelName;
        vodHeader.desc = channel.channelDesc;
        source.getResult(channel.channelId, function(result) {
            vodSource.categories = result;
            for (var index in vodSource.categories) {
                vodModel.append(vodSource.categories[index]);
            }
            currentLine = lineRepeater.itemAt(currentRow);
        });
    }
}

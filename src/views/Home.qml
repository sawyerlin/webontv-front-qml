import QtQuick 2.2

import "components"

View {
    property string imageServerPath: undefined
    property string imageBackground: "../images/homepage_bg.jpg"
    property string imageLogo: "../images/homepage_logo.png"
    property var source: undefined

    property int borderWidth: 5
    property int gridViewLeftMargin: 88
    property int gridViewTopMargin: 85
    property int gridViewBottomMargin: 40
    property int gridViewItemWidth: 362
    property int gridViewItemHeight: 192
    property int gridViewItemInnerWidth: gridViewItemWidth - 2 * borderWidth
    property int gridViewItemInnerHeight: gridViewItemHeight - 2 * borderWidth
    property int headerViewLeft: gridViewLeftMargin + borderWidth
    property int headerViewTop: 40

    property int rowSize: Math.floor((parent.width - gridViewLeftMargin) / gridViewItemWidth)
    property int rowIndex: Math.floor(focus.index / rowSize)
    property int columnIndex: focus.index - rowIndex * rowSize
    property int marginTop: 0

    signal play(int channelId)

    anchors.fill: parent
    Image {
        source: imageBackground 
    }
    Rectangle {
        clip: true;
        anchors.fill: parent
        color: "transparent"
        anchors.leftMargin: gridViewLeftMargin
        anchors.top: logo.bottom
        anchors.topMargin: gridViewTopMargin
        GridView {
            anchors.fill: parent
            anchors.topMargin: marginTop 
            ListModel {
                id: homeModel
            } 
            cellWidth: gridViewItemWidth
            cellHeight: gridViewItemHeight
            model: homeModel
            delegate: MosaicItem {
                name: model.name
                type: model.type
                margin: borderWidth
                background: model.background
                innerWidth: gridViewItemInnerWidth
                innerHeight: gridViewItemInnerHeight
            }
            Component.onCompleted: {
                if (source) {
                    source.getResult(function(result) {
                        for (var idx in result) {
                            homeModel.append(result[idx]);
                        }
                    });
                }
            }
            Border {
                id: focus
                width: gridViewItemWidth
                height: gridViewItemHeight
                border.width: borderWidth
                anchors.left: parent.left
                anchors.leftMargin: {
                    return columnIndex * gridViewItemWidth; 
                }
                anchors.top: parent.top
                anchors.topMargin: {
                    return rowIndex * gridViewItemHeight;
                }
            }
        }
    }
    Image {
        id: logo
        source: imageLogo
        anchors.left: parent.left
        anchors.leftMargin: headerViewLeft
        anchors.top: parent.top
        anchors.topMargin: headerViewTop
    }
    Keys.onPressed: {
        switch (event.key) {
            case Qt.Key_Left:
            if (focus.index > 0) {
                var scrollUp = false;
                if (columnIndex == 0) {
                    scrollUp = true;
                }
                focus.index --;
                if (scrollUp) {
                    updateMarginTopScrollUp();
                }
            }
            break;
            case Qt.Key_Right:
            if (focus.index < homeModel.count - 1) {
                var scrollDown = false;
                if (columnIndex + 1 == rowSize) {
                    scrollDown = true;
                }
                focus.index ++;
                if (scrollDown) {
                    updateMarginTopScrollDown();
                }
            }
            break;
            case Qt.Key_Up:
            if (focus.index - rowSize >= 0) {
                focus.index -= rowSize;
                updateMarginTopScrollUp();
            }
            break;
            case Qt.Key_Down:
            if (focus.index + rowSize < homeModel.count) {
                focus.index += rowSize;
                updateMarginTopScrollDown();
            }
            break
            case Qt.Key_Return: 
            play(homeModel.get(focus.index).id);
            break;
            default:
            break;
        }
    }
    onWidthChanged: {
        updateMarginTopScrollDown();
    }
    function playNextChannel() {
        focus.index ++;
        if (focus.index >= homeModel.count) {
            focus.index = 0
        } 
        play(homeModel.get(focus.index).id);
    }
    function playPrevChannel() {
        focus.index --;
        if (focus.index < 0) {
            focus.index = homeModel.count - 1;
        } 
        play(homeModel.get(focus.index).id);
    }
    function updateMarginTopScrollUp() {
        var top = rowIndex * gridViewItemHeight + marginTop;
        if (top < 0) {
            marginTop = marginTop - top;
        }
    }
    function updateMarginTopScrollDown() {
        var top = parent.height - marginTop - (rowIndex + 1) * gridViewItemHeight - gridViewTopMargin - gridViewBottomMargin;
        if (top < 0) {
            marginTop = top + marginTop;
        } else {
            marginTop = 0;
        }
    }
}

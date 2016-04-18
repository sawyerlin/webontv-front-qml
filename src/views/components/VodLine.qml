import QtQuick 2.2

Item {
    property var lineSource: undefined
    property alias headerName: header.text
    property int headerFontSize : 22
    property int headerMargin: 10
    property int wrapperHeight: 210
    property int headerHeight: headerFontSize + headerMargin * 2
    property int totalHeight: wrapperHeight + headerHeight
    property int leftMargin: 0
    property int wrapperLeftMargin: 0
    property int currentIndex: 0

    signal moveHorizontal()
    signal moveVertical(bool isUp)

    id: line
    height: wrapperHeight + headerHeight
    anchors.left: parent.left
    anchors.right: parent.right
    clip: true
    Text {
        id: header
        font.pixelSize: headerFontSize
        anchors.fill: parent
        anchors.topMargin: headerMargin
        anchors.bottomMargin: headerMargin
        color: "#3c3c3c"
        text: lineSource.name + " (" + lineSource.size + ")"
    }
    Item {
        id: wrapper
        anchors.fill: parent
        anchors.topMargin: headerHeight
        anchors.leftMargin: wrapperLeftMargin
        Row {
            anchors.fill: parent
            Repeater {
                id: itemRepeater
                model: lineSource.programs
                VodItem {
                    itemSource: model
                    focus: lineSource.index == 0 && model.index == currentIndex
                    onMoveLeft: {
                        if (index > 0) {
                            currentIndex = index - 1;
                            var currentItem = itemRepeater.itemAt(index),
                                previousItem = itemRepeater.itemAt(index - 1);
                            currentItem.focus = false;
                            previousItem.focus = true;
                            if (leftMargin - previousItem.totalWidth < 0) {
                                wrapperLeftMargin += currentItem.totalWidth;
                            } else {
                                leftMargin -= previousItem.totalWidth;
                            }
                            moveHorizontal();
                        }
                    }
                    onMoveRight: {
                        if (index + 1 < lineSource.programs.count) {
                            currentIndex = index + 1;
                            var currentItem = itemRepeater.itemAt(index),
                                nextItem = itemRepeater.itemAt(index + 1);
                            currentItem.focus = false;
                            nextItem.focus = true;
                            if (leftMargin + currentItem.totalWidth + nextItem.totalWidth > line.width) {
                                wrapperLeftMargin -= currentItem.totalWidth;
                            } else {
                                leftMargin += currentItem.totalWidth;
                            }
                            moveHorizontal();
                        }
                    }
                    onMoveUp: moveVertical(true)
                    onMoveDown: moveVertical(false)
                }
            }
        }
    }
    function getCurrentItemWidth() {
        return itemRepeater.itemAt(currentIndex).itemWidth;
    }
    function setFocus() {
        itemRepeater.itemAt(currentIndex).focus = true;
    }
    function unSetFocus() {
        itemRepeater.itemAt(currentIndex).focus = false;
    }
}

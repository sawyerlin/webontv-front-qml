import QtQuick 2.2

Item {
    property alias headerName: header.text
    property int headerFontSize : 22
    property int headerMargin: 10
    property int wrapperHeight: 210
    property int headerHeight: headerFontSize + headerMargin * 2
    property var lineSource: undefined
    property int leftMargin: 0
    property int wrapperLeftMargin: 0

    signal moveHorizontal(var item)
    signal moveVertical()

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
                id: programRepeater
                model: lineSource.programs
                VodItem {
                    itemSource: model
                    focus: lineSource.index == 0 && model.index == -1
                    onMoveLeft: {
                        if (index != -1) {
                            var currentItem = programRepeater.itemAt(index + 1),
                                previousItem = programRepeater.itemAt(index);
                            currentItem.focus = false;
                            previousItem.focus = true;
                            if (leftMargin - previousItem.totalWidth < 0) {
                                wrapperLeftMargin += currentItem.totalWidth;
                            } else {
                                leftMargin -= previousItem.totalWidth;
                            }
                            moveHorizontal(previousItem);
                        }
                    }
                    onMoveRight: {
                        if (index + 2 < lineSource.programs.count) {
                            var currentItem = programRepeater.itemAt(index + 1),
                                nextItem = programRepeater.itemAt(index + 2);
                            currentItem.focus = false;
                            nextItem.focus = true;
                            if (leftMargin + currentItem.totalWidth + nextItem.totalWidth > line.width) {
                                wrapperLeftMargin -= currentItem.totalWidth;
                            } else {
                                leftMargin += currentItem.totalWidth;
                            }
                            moveHorizontal(nextItem);
                        }
                    }
                    onMoveUp: console.log(index)
                    onMoveDown: console.log(index)
                }
            }
        }
    }
}

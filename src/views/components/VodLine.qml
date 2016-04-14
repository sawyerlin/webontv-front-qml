import QtQuick 2.2

Item {
    property alias headerName: header.text
    property int headerFontSize : 22
    property int headerMargin: 10
    property int wrapperHeight: 210
    property int headerHeight: headerFontSize + headerMargin * 2
    property var lineSource: undefined
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
                            programRepeater.itemAt(index + 1).focus = false;
                            programRepeater.itemAt(index).focus = true;
                        }
                    }
                    onMoveRight: {
                        if (index + 2 < lineSource.programs.count) {
                            console.log(programRepeater.itemAt(index + 1));
                            programRepeater.itemAt(index + 1).focus = false;
                            programRepeater.itemAt(index + 2).focus = true;
                        }
                    }
                    onMoveUp: console.log(index)
                    onMoveDown: console.log(index)
                }
                // TODO: update focus
            }
        }
    }
}

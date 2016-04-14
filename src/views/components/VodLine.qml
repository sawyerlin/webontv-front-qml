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
    Text {
        id: header
        font.pixelSize: headerFontSize
        anchors.fill: parent
        anchors.topMargin: headerMargin
        anchors.bottomMargin: headerMargin
        color: "#3c3c3c"
    }
    
    Item {
        id: wrapper
        anchors.fill: parent
        anchors.topMargin: headerHeight
        Row {
            anchors.fill: parent
            VodItem {
                itemWidth: 143
                backgroundColor: "#ff6600"//"#cccccc"
                backgroundFillMode: Image.PreserveAspectFit
                backgroundPositionX: 34
                backgroundPositionY: 130
            }
            Repeater {
                model: lineSource
                VodItem {itemSource: model}
            }
        }
    }
}

import QtQuick 2.2

Icon {
    property bool isSD: true
    property int hdTypeCount: 5
    property int sdTypeCount: 3
    anchors.rightMargin: 8
    positionX: -323
    Column {
        id: textItem
        visible: false
        anchors.top: parent.top
        anchors.topMargin: -70
        anchors.left: parent.left
        Row {
            Repeater {
                id: hdType
                model: hdTypeCount
                QualityType {color: "gray"}
            }
            Rectangle {
                width: 10
                height: 15
                color: "transparent"
            }
            Text {
                id: hdText
                text: "HD"
                color: "gray"
                font.pixelSize: 15
                font.bold: true
                anchors.leftMargin: 20
            }
        }
        Row {
            Repeater {
                id: sdType
                model: sdTypeCount
                QualityType {color: "white"}
            }
            Rectangle {
                width: 20
                height: 15
                color: "transparent"
            }
            Text {
                id: sdText
                text: "voir en SD"
                color: "white"
                font.pixelSize: 15
                font.bold: true
                anchors.leftMargin: 20
            }
        }
    }
    onPressed: {
        isSD = !isSD;
        if (isSD) {
            for (var i = 0; i < hdTypeCount; i ++) {
                hdType.itemAt(i).color = "gray";
            }
            for (i = 0; i < sdTypeCount; i++) {
                sdType.itemAt(i).color = "white";
            }
            sdText.text = "voir en SD";
            sdText.color = "white";
            hdText.text = "HD";
            hdText.color = "gray";
        } else {
            for (var i = 0; i < hdTypeCount; i++) {
                hdType.itemAt(i).color = "white";
            }
            for (i = 0; i < sdTypeCount; i++) {
                sdType.itemAt(i).color = "gray";
            }
            sdText.text = "SD";
            sdText.color = "gray";
            hdText.text = "voir en HD";
            hdText.color = "white";
        }
    }
    onShown: textItem.visible = true
    onHidden: textItem.visible = false
}

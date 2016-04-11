import QtQuick 2.2

Row {
    property alias color: rect.color
    Rectangle {
        id: rect
        width: 3
        height: 15
    }
    Rectangle {
        width: 2
        height: 15
        color: "transparent"
    }
}

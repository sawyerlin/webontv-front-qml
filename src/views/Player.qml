import QtQuick 2.2

Rectangle {
    property variant source: undefined
    property variant channel: undefined

    anchors.fill: parent
    color: "black"
    Text {
        text: "Player"
        color: "white"
    }
    Keys.onPressed: {
        switch (event.key) {
            case Qt.Key_Backspace:
            parent.back();
            break;
        }
    }
}

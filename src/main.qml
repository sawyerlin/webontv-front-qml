import QtQuick 2.2
import fbx.application 1.0

import "views"

Rectangle {
    property int applicationWidth: 850
    property int applicationHeight: 720
    width: applicationWidth
    height: applicationHeight
    color: "white"
    Home {focus: true}
}

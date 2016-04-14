import QtQuick 2.2

import "mediaelements"

Item {
    property alias logoSource: liveLogo.source
    property alias channelName: channelName.text
    property alias programName: programName.text
    property var currentItem: undefined

    property var returnItem: undefined 
    property var playbackItem: undefined
    property var qualityItem: undefined 
    property var vodItem: undefined
    property var outBoundItem: undefined

    signal backClicked();
    signal playBackClicked(bool paused);
    signal qualityClicked();
    signal vodClicked();
    signal moveOutBound();

    onActiveFocusChanged: {
        console.log(focus);
    }
    Image {
        id: liveLogo
        width: 85
        height: 63
    }
    Item {
        anchors.left: liveLogo.right
        anchors.leftMargin: 15
        Text {
            id: channelName
            font.pixelSize: 25
            font.bold: true
            color: "white"
        }
        Text {
            id: programName
            anchors.top: channelName.bottom
            anchors.topMargin: 5
            font.pixelSize: 25
            font.bold: true
            color: "white"
        }
    }
    Item {
        anchors.right: parent.right
        width: 50
        VodIcon {
            id: iconvod
            onPressed: vodClicked();
        }
        QualityIcon {
            id: iconquality
            anchors.right: iconvod.left
            onPressed: qualityClicked()
        }
        PlaybackIcon {
            id: iconplayback
            anchors.right: iconquality.left
            onPressed: playBackClicked(iconplayback.paused)
        }
        BackIcon {
            id: iconreturn
            anchors.right: iconplayback.left
            onPressed: {
                currentItem = undefined;
                iconplayback.reset();
                backClicked();
            }
        }
        Component.onCompleted: {
            returnItem = {
                item: iconreturn,
                previous: undefined
            };
            playbackItem = {
                item: iconplayback, 
                previous: returnItem
            };
            returnItem.next = playbackItem;
            qualityItem = {
                item: iconquality, 
                previous: playbackItem 
            }
            playbackItem.next = qualityItem;
            vodItem = {
                item: iconvod,
                previous: qualityItem
            };
            qualityItem.next = vodItem;
            outBoundItem = {
                item: {
                    show: function() { 
                        unSetFocus();
                        moveOutBound(); 
                    },
                    hide: function() {}
                },
                previous: vodItem
            };
            vodItem.next = outBoundItem;
        }
    }
    Keys.onPressed: {
        if (event.key == Qt.Key_Right) {
            move(currentItem.next);
        } else if (event.key == Qt.Key_Left) {
            move(currentItem.previous);
        }
    }
    function setFocus(item) {
        currentItem = item || (currentItem != undefined ? currentItem.previous : returnItem);
        currentItem.item.show();
    }
    function unSetFocus() {
        if (currentItem && currentItem.item != undefined) {
            currentItem.item.hide();
        }
    }
    function move(item) {
        if (item) {
            unSetFocus();
            setFocus(item);
        }
    }
}

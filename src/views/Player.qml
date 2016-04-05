import QtQuick 2.2
import QtMultimedia 5.2

import "components"

Rectangle {
    property variant source: undefined
    property variant channel: undefined
    id: videoVeiw
    anchors.fill: parent
    color: "black"
    Video {
        id: video
        anchors.fill: parent
        source: "../videos/BigBuckBunny.avi"
    }
    VideoController {
        id: videoController
    }
    Keys.onPressed: {
        switch (event.key) {
            case Qt.Key_Backspace:
            parent.back();
            break;
            case Qt.Key_Return:
            switch (video.playbackState) {
                case MediaPlayer.PlayingState:
                video.pause();
                break;
                case MediaPlayer.PausedState:
                video.play();
                break;
                case MediaPlayer.StoppedState:
                video.play();
                break;
            }
            default:
            break;
        }
    }
}

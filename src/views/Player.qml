import QtQuick 2.2
import QtMultimedia 5.2

import "components"

Rectangle {
    id: videoVeiw
    anchors.fill: parent
    color: "black"
    Video {
        id: video
        anchors.fill: parent
        source: "../videos/BigBuckBunny.avi"
        onPositionChanged: {
            videoController.updateCurrentPosition(video.position, video.duration);
        }
    }
    VideoController {
        id: videoController
    }
    Keys.onPressed: {
        switch (event.key) {
            case Qt.Key_Return:
            switch (videoController.currentIndex) {
                case 0:
                videoController.updatePlayback(false);
                video.stop();
                parent.back();
                break;
                case 1:
                var pause = false;
                switch (video.playbackState) {
                    case MediaPlayer.PlayingState:
                    pause = true;
                    video.pause();
                    break;
                    case MediaPlayer.PausedState:
                    pause = false;
                    video.play();
                    break;
                }
                videoController.updatePlayback(pause);
                break;
                case 2:
                // TODO: change quality
                break;
                case 3:
                // TODO: show vod home
                break;
            }
            default:
            videoController.move(event.key);
            break;
        }
    }
    function play(chanel) {
        video.play();
        videoController.init(chanel, video.duration);
    }
}

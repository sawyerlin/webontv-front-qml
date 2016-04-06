import QtQuick 2.2
import QtMultimedia 5.2

import "components"

View {
    property variant source: undefined
    property string imageServerPath: undefined

    signal back()

    anchors.fill: parent
    color: "black"
    onHiden: {
        videoController.updateCurrentPosition(0);
        videoController.focus = false;
    }
    onShown: videoController.focus = true
    Video {
        id: video
        anchors.fill: parent
        autoPlay: true
        onDurationChanged: videoController.duration = video.duration
        onPositionChanged: videoController.updateCurrentPosition(video.position)
    }
    VideoController {
        id: videoController 
        imageServerPath: parent.imageServerPath
        Keys.onPressed: {
            switch (event.key) {
                case Qt.Key_Return:
                switch (videoController.currentIndex) {
                    case 0:
                    videoController.updatePlayback(false);
                    video.stop();
                    back();
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
    }
    function play(data) {
        video.source = data.program.source;
        video.play();
        videoController.init(data);
    }
}

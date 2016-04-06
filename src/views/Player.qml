import QtQuick 2.2
import QtMultimedia 5.2

import "components"

View {
    property variant source: undefined
    property string imageServerPath: undefined
    signal back()
    anchors.fill: parent
    onHiden: videoController.focus = false
    onShown: videoController.focus = true
    color: "black"
    Video {
        id: video
        anchors.fill: parent
        autoPlay: true
        onPlaying: {
        }
        onPositionChanged: {
            videoController.updateCurrentPosition(video.position, video.duration);
        }
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
    function play(chanel, program) {
        for (var videoId in program.ProgramToPlay.Videos) {
            video.source = program.ProgramToPlay.Videos[videoId].filepath;
            break;
        }
        videoController.init(chanel, video.duration, program);
    }
}

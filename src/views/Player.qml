import QtQuick 2.2
import QtMultimedia 5.2

import "components"

View {
    property variant source: undefined
    property string imageServerPath: undefined

    signal playerBack()

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
        onBack: {
            video.stop();
            playerBack();
        }
        onPause: {
            video.pause();
        }
        onPlay: {
            video.play();
        }
    }
    function play(data) {
        video.source = data.program.source;
        video.play();
        videoController.init(data);
    }
}

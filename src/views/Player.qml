import QtQuick 2.2
import QtMultimedia 5.2

import "components"

View {
    property var source: undefined
    property string imageServerPath: undefined
    property string currentQuality: "SD"
    property var dataSource: undefined
    property bool isStoping: true

    signal playerBack() 
    signal playPrevChannel();
    signal playNextChannel();

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
        onStopped: {
            if (isStoping) {
                var nextProgram = dataSource.program.nextProgram,
                currentProgram = dataSource.program.currentProgram;
                parent.source.getProgram(dataSource.channelId,
                currentProgram.playlistId,
                currentProgram.order,
                currentProgram.playlistOrder,
                currentProgram.playlistId == nextProgram.playlistId ?
                nextProgram.playlistId : undefined,
                function(program) {
                    dataSource.program = program;
                    video.source = dataSource.program.currentProgram.source[currentQuality];
                    video.play();
                    videoController.init(dataSource);
                });
            } else {
                isStoping = true;
            }
        }
    }
    VideoController {
        id: videoController 
        onBack: {
            isStoping = false;
            video.stop();
            playerBack();
        }
        onPause: video.pause()
        onPlay: video.play()
        onQualityChanged: {
            if (currentQuality == "SD") {
                currentQuality = "HD";
            } else {
                currentQuality = "SD";
            }
            if (dataSource.program.currentProgram.source[currentQuality]) {
                isStoping = false;
                video.stop();
                video.source = dataSource.program.currentProgram.source[currentQuality];
                video.play();
            }
        }
        onVod: console.log("show vod home")
        onNext: video.stop()
        onPrevChannel: {
            isStoping = false;
            video.stop();
            playPrevChannel();
        }
        onNextChannel: {
            isStoping = false;
            video.stop();
            playNextChannel();
        }
    }
    function play(channelId) {
        source.getResult(channelId, function(data) {
            dataSource = data;
            video.source = dataSource.program.currentProgram.source[currentQuality];
            video.play();
            videoController.init(dataSource);
        });
    }
}

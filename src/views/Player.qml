import QtQuick 2.2
import QtMultimedia 5.2

import "components"

View {
    property var source: undefined
    property string imageServerPath: undefined
    property var dataSource: undefined
    property bool isBacking: false

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
        onStopped: {
            if (!isBacking) {
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
                    video.source = dataSource.program.currentProgram.source;
                    video.play();
                    videoController.init(dataSource);
                });
            } else {
                isBacking = false;
            }
        }
    }
    VideoController {
        id: videoController 
        onBack: {
            isBacking = true;
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
    function play(channelId) {
        source.getResult(channelId, function(data) {
            dataSource = data;
            video.source = dataSource.program.currentProgram.source;
            video.play();
            videoController.init(dataSource);
        });
    }
}

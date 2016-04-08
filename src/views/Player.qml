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
    onHiden: videoController.unSetFocus()
    onShown: videoController.setFocus()
    Image {
        id: image
        anchors.fill: parent
    }
    Video {
        id: video
        anchors.fill: parent
        onDurationChanged: videoController.duration = video.duration
        onPositionChanged: videoController.updateCurrentPosition(video.position)
        onStopped: {
            if (isStoping) {
                playNextVideo();
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
        onVod: console.log("show vod home") // TODO: show vod home page
        onNext: video.visible ? video.stop() : playNextVideo() 
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
        onImageEnd: playNextVideo();
    }
    function play(channelId) {
        source.getResult(channelId, function(data) {
            dataSource = data;
            loadVideo();
            videoController.init(dataSource);
        });
    }
    function playNextVideo() {
        video.visible = true;
        var nextProgram = dataSource.program.nextProgram,
        currentProgram = dataSource.program.currentProgram;
        source.getProgram(dataSource.channelId,
        currentProgram.playlistId,
        currentProgram.order,
        currentProgram.playlistOrder,
        currentProgram.playlistId == nextProgram.playlistId ?
        nextProgram.playlistId : undefined,
        function (program) {
            dataSource.program = program;
            loadVideo();
            videoController.init(dataSource);
        });
    }
    function loadVideo() {
        if (dataSource.program.currentProgram.type == "1") { // Image
            video.visible = false;
            videoController.setDuration(dataSource.program.currentProgram.duration);
            image.source = dataSource.program.currentProgram.imageSource;
        } else {
            video.source = dataSource.program.currentProgram.source[currentQuality];
            video.play();
        }
    }
}

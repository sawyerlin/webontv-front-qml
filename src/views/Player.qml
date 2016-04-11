import QtQuick 2.2
import QtMultimedia 5.2

import "components"

View {
    property var source: undefined
    property string imageServerPath: undefined
    property string sdType: "SD"
    property string hdType: "HD"
    property string currentQuality: sdType
    property var dataSource: undefined
    property bool isStoping: true

    signal playerBack(int position) 
    signal playerVod(int position);
    signal playPrevChannel(int position);
    signal playNextChannel(int position);

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
        onStopped: isStoping ? playNextVideo() : isStoping = true
    }
    VideoController {
        id: videoController 
        onBack: playerBack(stop());
        onPause: video.pause()
        onPlay: video.play()
        onQualityChanged: {
            var lastPosition = video.position;
            currentQuality = currentQuality == sdType ? hdType : sdType;
            if (dataSource.program.currentProgram.source[currentQuality]) {
                isStoping = false;
                video.stop();
                video.source = dataSource.program.currentProgram.source[currentQuality];
                video.play();
                video.seek(lastPosition);
            }
        }
        onVod: playerVod(stop())
        onNext: video.visible ? video.stop() : playNextVideo() 
        onPrevChannel: playPrevChannel(stop())
        onNextChannel: playNextChannel(stop())
        onImageEnd: playNextVideo()
    }
    function play(channelId) {
        source.getResult(channelId, function(data) {
            dataSource = data;
            loadVideo();
            videoController.init(dataSource);
        });
    }
    function stop() {
        source.storage.saveState({
            channelId: dataSource.channelId,
            programId: dataSource.program.currentProgram.id,
            position: video.position
        });
        isStoping = false;
        video.stop();
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

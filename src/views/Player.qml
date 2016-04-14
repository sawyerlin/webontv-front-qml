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
    signal playerVod(var channel);
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
        onBack: playerBack(stop())
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
        onVod: {
            stop();
            playerVod(dataSource);
        }
        onNext: video.visible ? video.stop() : playNextVideo() 
        onPrevChannel: playPrevChannel(stop())
        onNextChannel: playNextChannel(stop())
        onImageEnd: playNextVideo()
    }
    function start(channelId) {
        source.getResult(channelId, function(data) {
            dataSource = data;
            source.storage.getState(channelId, function(result) {
                if (result) {
                    play(result, function() {video.seek(result.position);});
                } else {
                    source.getProgram(channelId, undefined, undefined, undefined, undefined, function(program) {
                        dataSource.program = program;
                        loadVideo();
                        videoController.init(dataSource);
                    });
                }
            });
        });
    }
    function stop() {
        var program = dataSource.program.currentProgram;
        source.storage.saveState({
            channelId: dataSource.channelId,
            playlistId: program.playlistId,
            order: program.order == 0 ? 0 : program.order - 1,
            playlistOrder: program.playlistOrder,
            finishedPlaylistId: program.finishedPlaylistId,
            position: video.position
        });
        isStoping = false;
        video.stop();
    }
    function play(program, callback) {
        source.getProgram(program.channelId, 
        program.playlistId, 
        program.order, 
        program.playlistOrder, 
        program.finishedPlaylistId, 
        function (result) {
            dataSource.program = result;
            loadVideo();
            videoController.init(dataSource);
            if (callback) {
                callback();
            }
        });
    }
    function playNextVideo() {
        video.visible = true;
        var nextProgram = dataSource.program.nextProgram,
        currentProgram = dataSource.program.currentProgram;
        play({
            channelId: dataSource.channelId,
            playlistId: currentProgram.playlistId,
            order: currentProgram.order,
            playlistOrder: currentProgram.playlistOrder,
            playlistId: currentProgram.playlistId == nextProgram.playlistId ?
            nextProgram.playlistId : undefined
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

import QtQuick 2.2
import fbx.application 1.0

import "config"
import "source"
import "views"

Rectangle {
    property int applicationWidth: 1280
    property int applicationHeight: 720
    property var lastView: undefined
    property var currentView: homeView
    property var views: [homeView, playerView]
    width: applicationWidth
    height: applicationHeight
    color: "white"
    Config {id: config}
    Home {
        id: homeView 
        imageServerPath: config.imageServerPath
        source: HomeSource {config: config}
        onPlay: {
            playerView.play(channelId);
            showView(playerView);
        }
    }
    Player {
        id: playerView
        imageServerPath: config.imageServerPath
        source: LivePlayerSource {config: config}
        onPlayerBack: showView(lastView)
        onPlayerVod: console.log("vod")
        onPlayPrevChannel: homeView.playPrevChannel()
        onPlayNextChannel: homeView.playNextChannel()
    }
    Component.onCompleted: {
        showView(homeView);
    }
    function showView(view) {
        if (view) {
            lastView = currentView;
            for (var index in views) {
                if (views[index] == view) {
                    continue;
                }
                views[index].hide();
            }
            if (view) {
                view.show();
            }
        }
    }
}

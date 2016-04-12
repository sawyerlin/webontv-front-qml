import QtQuick 2.2
import fbx.application 1.0

import "config"
import "source"
import "views"

Rectangle {
    property int applicationWidth: 1280
    property int applicationHeight: 720
    property var currentView: homeView
    property var views: [homeView, playerView, vodView]
    width: applicationWidth
    height: applicationHeight
    color: "white"
    Config {id: config}
    Home {
        id: homeView 
        imageServerPath: config.imageServerPath
        source: HomeSource {config: config}
        onPlay: {
            playerView.start(channelId);
            showView(playerView);
        }
    }
    Player {
        id: playerView
        imageServerPath: config.imageServerPath
        source: LivePlayerSource {config: config}
        onPlayerBack: showView(homeView)
        onPlayerVod: showView(vodView)
        onPlayPrevChannel: homeView.playPrevChannel()
        onPlayNextChannel: homeView.playNextChannel()
    }
    Vod {
        id: vodView
        onBack: {
            playerView.start(2);
            showView(playerView)
        }
    }
    Component.onCompleted: {
        showView(homeView);
    }
    function showView(view) {
        if (view) {
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

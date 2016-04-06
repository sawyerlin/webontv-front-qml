import QtQuick 2.2
import fbx.application 1.0

import "config"
import "source"
import "views"

Rectangle {
    property int applicationWidth: 1280
    property int applicationHeight: 720
    property variant lastView: undefined
    property variant currentView: homeView
    property variant views: [homeView, playerView]
    width: applicationWidth
    height: applicationHeight
    color: "white"
    Config {id: config}
    Source {
        id: source
        config: config
    }
    Home {
        id: homeView 
        imageServerPath: config.imageServerPath
        onPlay:  {
            source.getChannelById(chanelId, function(result) {
                showView(playerView);
                source.getProgramToPlay(chanelId, function(program) {
                    playerView.play(result.Channel, program);
                });
            });
        }
        source: source
    }
    Player {
        id: playerView
        imageServerPath: config.imageServerPath
        onBack: {
            showView(lastView);
        }
        source: source
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

import QtQuick 2.2
import fbx.application 1.0

import "views"
import "source"

Rectangle {
    property int applicationWidth: 1280
    property int applicationHeight: 720
    width: applicationWidth
    height: applicationHeight
    color: "white"
    Source {id: source}
    Home {
        id: homeView
        focus: true
        visible: true
        source: source
    }
    Player {
        id: playerView
        focus: false
        visible: false
    }
    function play(channelId) {
        source.getChannelById(channelId, function(result) {
            playerView.channel = result;
        });
        homeView.focus = false;
        homeView.visible = false;
        playerView.focus = true;
        playerView.visible = true;
    }
    function back() {
        homeView.focus = true;
        homeView.visible = true;
        playerView.focus = false;
        playerView.visible = false;
    }
}

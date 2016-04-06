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
                var chanel = result.Channel;
                console.log(chanel.name);
                source.getProgramToPlay(chanelId, function(program) {
                    // TODO: put this code into the source file
                    var data = {
                        chanelName: chanel.name,
                        logo: config.imageServerPath + chanel.logoLiveFilepath,
                        program: {
                            name: program.ProgramToPlay.title,
                            source: (function() { 
                                // TODO: get the right source
                                for (var videoId in program.ProgramToPlay.Videos) {
                                    return program.ProgramToPlay.Videos[videoId].filepath;
                                }
                            })()
                        },
                        nextProgram: {
                            imageSource: config.imageServerPath + program.NextProgram.imageFilepath,
                            text: program.NextProgram.title
                        }
                    };
                    playerView.play(data);
                    showView(playerView);
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

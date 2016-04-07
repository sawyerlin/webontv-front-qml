import QtQuick 2.2

Source {
    function getResult(channelId, callback) {
        getChannelById(channelId, function(result) {
            var channel = result.Channel;
            var data = {
                channelId: channelId,
                channelName: channel.name,
                logo: config.imageServerPath + channel.logoLiveFilepath,
                program: {
                    currentProgram: {},
                    nextProgram: {}
                }
            };
            getProgram(channelId, undefined, undefined, undefined, undefined, function(program) {
                data.program = program;
                callback(data);
            });
        });
    }
    function getProgram(channelId, playlistId, order, playlistOrder, finishedPlaylistId, callback) {
        getProgramToPlay(channelId, playlistId, order, playlistOrder, finishedPlaylistId, function(result) {
            var program = {
                currentProgram: {
                    playlistId: result.ProgramToPlay.Playlist.id,
                    order: result.ProgramToPlay.int_order,
                    playlistOrder: result.ProgramToPlay.Playlist.int_order,
                    name: result.ProgramToPlay.title,
                    // TODO: get the right source
                    source: (function() {
                        for (var videoId in result.ProgramToPlay.Videos) {
                            return result.ProgramToPlay.Videos[videoId].filepath;
                        }
                    })()
                },
                nextProgram: {
                    playlistId: result.NextProgram.Playlist.id,
                    imageSource: config.imageServerPath + result.NextProgram.imageFilepath,
                    text: result.NextProgram.title
                }
            }
            callback(program);
        });
    }
}

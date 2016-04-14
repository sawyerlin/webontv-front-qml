import QtQuick 2.2

Source {
    function getResult(channelId, callback) {
        getChannelById(channelId, function(result) {
            var channel = result.Channel,
            data = {
                channelId: channelId,
                channelName: channel.name,
                channelDesc: channel.genre,
                liveLogo: config.imageServerPath + channel.logoLiveFilepath,
                vodLogo: config.imageServerPath + channel.logoFilepath,
                banner: config.imageServerPath + channel.bannerFilepath,
                program: {
                    currentProgram: {},
                    nextProgram: {}
                }
            };
            callback(data);
        });
    }
    function getProgram(channelId, playlistId, order, playlistOrder, finishedPlaylistId, callback) {
        getProgramToPlay(channelId, playlistId, order, playlistOrder, finishedPlaylistId, function(result) {
            var program = {
                currentProgram: {
                    id: result.ProgramToPlay.id,
                    playlistId: result.ProgramToPlay.Playlist.id,
                    order: result.ProgramToPlay.int_order,
                    playlistOrder: result.ProgramToPlay.Playlist.int_order,
                    duration: result.ProgramToPlay.duration,
                    imageSource: config.imageServerPath + result.ProgramToPlay.imageFilepath,
                    type: result.ProgramToPlay.skin_type,
                    name: result.ProgramToPlay.title,
                    source: (function() {
                        var source = {};
                        for (var videoId in result.ProgramToPlay.Videos) {
                            var video = result.ProgramToPlay.Videos[videoId];
                            source[video.quality] = video.filepath;
                        }
                        return source;
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

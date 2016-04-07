import QtQuick 2.2

Source {
    function getResult(callback) {
        getChannels(function(result) {
            var returnValue = [];
            if (result) {
                var channels = result.Channels;
                for (var index in channels) {
                    var channel = channels[index];
                    returnValue.push({
                        id: channel.id,
                        name: channel.tvchannel + " - " + channel.name,
                        type: channel.genre,
                        tvchannel: channel.tvchannel,
                        background: config.imageServerPath + channel.image
                    });
                }
            }
            callback(returnValue);
        });
    }
}

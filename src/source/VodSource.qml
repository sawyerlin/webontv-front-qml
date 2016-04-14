import QtQuick 2.2

Source {
    function getResult(channelId, callback) {
        getVodPrograms(channelId, 10, function(result) {
            callback(result);
        });
    }
}

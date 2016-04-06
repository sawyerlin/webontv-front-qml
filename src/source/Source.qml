import QtQuick 2.2

Item {
    property variant config: undefined 

    function getChannels(callback) {
        var url = config.serviceServerPath + "/Channels/getChannels.json";
        var xhr = new XMLHttpRequest;
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState != xhr.DONE) {
                return false;
            }
            if (callback) {
                callback(xhr.responseText ? JSON.parse(xhr.responseText) : null);
            }
        }
        xhr.send();
        return true;
    }

    function getChannelById(channelId, callback) {
        var url = config.serviceServerPath + "/Channels/getChannelById.json?channelId=" + channelId;
        var xhr = new XMLHttpRequest;
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState != xhr.DONE) {
                return false;
            }
            if (callback) {
                callback(xhr.responseText ? JSON.parse(xhr.responseText) : null);
            }
        }
        xhr.send();
        return true;
    }

    function getProgramToPlay(channelId, callback) {
        var url = config.serviceServerPath + "/Programs/getProgramToPlay.json?channelId=" + channelId + "&stbDate=" + Math.round(Date.now() / 1000);
        var xhr = new XMLHttpRequest;
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState != xhr.DONE) {
                return false;
            }
            if (callback) {
                callback(xhr.responseText ? JSON.parse(xhr.responseText) : null);
            }
        }
        xhr.send();
        return true;
    }
}

import QtQuick 2.2

Item {
    property string server: "http://fo-orange.preprod.hubee.tv"

    function getChannels(callback) {
        var url = server + "/Channels/getChannels.json";
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
        var url = server + "/Channels/getChannelById.json?channelId=" + channelId;
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

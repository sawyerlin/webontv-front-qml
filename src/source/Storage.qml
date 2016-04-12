import QtQuick.LocalStorage 2.0
import QtQuick 2.2

Item {
    function saveState(data) {
        var db = LocalStorage.openDatabaseSync("database", "1.0", "WTV", 1000000);
        db.transaction(
            function(tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS State(channelId INT, playlistId INT, programOrder INT, playlistOrder INT, finishedPlaylistId INT, position INT, PRIMARY KEY (channelId))");
                tx.executeSql("INSERT OR IGNORE INTO State VALUES(?, ?, ?, ?, ?, ?)", [data.channelId, data.playlistId, data.order, data.playlistOrder, data.finishedPlaylistId, data.position]);
                tx.executeSql("UPDATE State SET playlistId = ?, programOrder = ?, playlistOrder = ?, finishedPlaylistId = ?, position = ? WHERE channelId = ?", [data.playlistId, data.order, data.playlistOrder, data.finishedPlaylistId, data.position, data.channelId]);
            }
        );
    }

    function getState(channelId, callback) {
        var db = LocalStorage.openDatabaseSync("database", "1.0", "WTV", 1000000);
        db.transaction(
            function(tx) {
                try {
                    var rs = tx.executeSql("SELECT * FROM State WHERE channelId = ?", [channelId]);
                    var item = rs.rows.item(rs.rows.length - 1);
                    callback(item ? {
                        channelId: channelId,
                        playlistId: item.playlistId,
                        order: item.programOrder,
                        playlistOrder: item.playlistOrder,
                        finishedPlayerlistId: item.finishedPlaylistId,
                        position: item.position
                    } : undefined);
                } catch (e) {
                    // TODO: show error message here
                    callback(undefined);
                }
            }

        );
    }
}

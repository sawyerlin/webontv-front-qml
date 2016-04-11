import QtQuick.LocalStorage 2.0
import QtQuick 2.2

Item {
    function saveState(data) {
        var db = LocalStorage.openDatabaseSync("database", "1.0", "WTV", 1000000);
        db.transaction(
            function(tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS State(channelId INT, programId INT, position INT, PRIMARY KEY (channelId))");
                tx.executeSql("INSERT OR IGNORE INTO State VALUES(?, ?, ?)", [data.channelId, data.programId, data.position]);
                tx.executeSql("UPDATE State SET programId = ?, position = ? WHERE channelId = ?", [data.programId, data.position, data.channelId]);
                var rs = tx.executeSql("SELECT * FROM State");
                for (var i = 0; i < rs.rows.length; i++) {
                    var item = rs.rows.item(i);
                    console.log(item.channelId + " " + item.programId + " " + item.position);
                }
            }
        );
    }

    function getState(channelId, callback) {
        var db = LocalStorage.openDatabaseSync("database", "1.0", "WTV", 1000000);
        db.transaction(
            function(tx) {
                var rs = tx.executeSql("SELECT * FROM State WHERE channelId=?", [channelId]);
                var item = rs.rows.item[0];
                callback(item ? {
                    channelId: channelId,
                    programId: programId,
                    position: item.position
                } : undefined);
            }
        );
    }
}

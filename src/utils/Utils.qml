import QtQuick 2.2

Item {
    function timeToMS(time) {
        var a = time.split(':'),
        l = a.length,
        r = 0;
        r += +a[l - 1] || 0;
        r += (+a[l - 2] * 60) || 0;
        r += (+a[l - 3] * 3600) || 0;
        return r * 1000;
    }
    function timeToHHMMSS(time) {
        if (time) {
            var a = time.split(':'),
            heures = a[0],
            minutes = a[1],
            seconds = a[2];
            if (heures != '00') {
                return heures + ':' + minutes + ':' + seconds;
            } else {
                return minutes + ':' + seconds;
            }
        } else {
            return "";
        }
    }
    function getDays(time) {
        return Math.round((Date.now() / 1000 - time) / 86400);
    }
}

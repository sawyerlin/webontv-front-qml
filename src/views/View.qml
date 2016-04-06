import QtQuick 2.2

Rectangle {
    signal shown()
    signal hiden()
    function show() {
        this.visible = true;
        this.focus = true;
        this.shown();
    }
    function hide() {
        this.visible = false;
        this.focus = false;
        this.hiden();
    }
}

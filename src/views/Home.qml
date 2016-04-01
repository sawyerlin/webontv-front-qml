import QtQuick 2.2

import "../source"
import "components"

Rectangle {
    property int borderWidth: 5
    property int gridViewLeft: 88
    property int gridViewTop: 85
    property int gridViewItemWidth: 362
    property int gridViewItemHeight: 192
    property int gridViewItemInnerWidth: gridViewItemWidth - 2 * borderWidth
    property int gridViewItemInnerHeight: gridViewItemHeight - 2 * borderWidth
    property int headerViewLeft: gridViewLeft + borderWidth
    property int headerViewTop: 40
    property string imageServer: "http://fo-orange-preprod.hubee.tv/elts/"
    property string imageBackground: "../images/homepage_bg.jpg"
    property string imageLogo: "../images/homepage_logo.png"
    anchors.fill: parent
    Image {
        source: imageBackground 
    }
    Image {
        id: logo
        anchors.left: parent.left
        anchors.leftMargin: headerViewLeft
        anchors.top: parent.top
        anchors.topMargin: headerViewTop
        source: imageLogo
    }
    GridView {
        id: homeView
        ListModel {
            id: homeModel
        } 
        cellWidth: gridViewItemWidth
        cellHeight: gridViewItemHeight
        model: homeModel
        delegate: MosaicItem {
            name: model.name
            type: model.type
            margin: borderWidth
            background: model.background
            innerWidth: gridViewItemInnerWidth
            innerHeight: gridViewItemInnerHeight
        }
        anchors.fill: parent
        anchors.leftMargin: gridViewLeft
        anchors.topMargin: gridViewTop
        Source {id: source}
        Component.onCompleted: {
            source.getChannels(function(result) {
                if (result) {
                    var channels = result.Channels;
                    for (var index in channels) {
                        var channel = channels[index];
                        homeModel.append({
                            id: channel.id,
                            name: channel.tvchannel + " - " + channel.name,
                            type: channel.genre,
                            tvchannel: channel.tvchannel,
                            background: imageServer + channel.image
                        });
                    }
                }
            })
        }
    }
    Border {
        id: focusBorder
        width: gridViewItemWidth
        height: gridViewItemHeight
        anchors.left: parent.left
        border.width: borderWidth
        anchors.leftMargin: gridViewLeft
        anchors.top: parent.top
        anchors.topMargin: gridViewTop
    }
}

import QtQuick 2.2

import "../source"
import "components"

Rectangle {
    anchors.fill: parent
    Image {
        source: "../images/homepage_bg.jpg"
    }
    Image {
        id: logo
        anchors.left: parent.left
        anchors.leftMargin: 96
        anchors.top: parent.top
        anchors.topMargin: 40
        source: "../images/homepage_logo.png"
    }
    GridView {
        id: homeView
        ListModel {
            id: homeModel
        } 
        cellWidth: 365
        cellHeight: 195
        model: homeModel
        delegate: MosaicItem {
            name: model.name
            type: model.type
            background: model.background
        }
        anchors.topMargin: 90
        anchors.fill: parent
        anchors.leftMargin: 93
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
                            background: "http://fo-orange-preprod.hubee.tv/elts/" + channel.image
                        });
                    }
                }
            })
        }
    }
}

# WEBONTV QML

> Start Application
sshpass -p $PASSWD ssh docker@$IPADDR DISPLAY=:10 qmlscene submodules/webontv-front-qml/src/main.qml -I /home/docker/submodules/libfbxqml

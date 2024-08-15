import QtQuick 2.0

Rectangle {
    id: borderRect
    width: 200
    height: 100
    property int myButtomMargin: 0
    property int myTopMargin: 0
    color: "black"
    Rectangle{
        id: innerRect
        color: "blue"
        anchors.fill: parent
        anchors.topMargin: myTopMargin
        anchors.bottomMargin: myButtomMargin
        anchors.leftMargin: 0
        anchors.rightMargin: 0
    }
}

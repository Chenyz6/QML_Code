import QtQuick 2.12
import QtQuick.Window 2.12
import QtPositioning 5.12
import QtLocation 5.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Map{
        anchors.fill:parent
        plugin: Plugin{name: "amap"}
        center: QtPositioning.coordinate(30.31395012, 120.35185575) // 纬度 经度
        zoomLevel: 18;
    }
}

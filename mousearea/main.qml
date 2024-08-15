import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle{
        id: container
        width: 600; height: 200
        x: 0; y: 300
        Rectangle{
            id: rect
            width: 50; height: 50
            color: "red"
            opacity: (600.0 - rect.x) / 600
            MouseArea {
                anchors.fill: parent
                drag.target: rect
                drag.axis: Drag.XAxis | Drag.YAxis
                drag.minimumX: 0
                drag.maximumX: container.width - rect.width
            }
        }
    }


    // 子鼠标事件传递
    Rectangle {
        color: "yellow"
        width: 100; height: 100

        x: 300
        y: 300
        MouseArea {
            anchors.fill: parent
            onClicked: console.log("clicked yellow")
        }

        Rectangle {
            color: "blue"
            width: 50; height: 50

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                onClicked: {
                    console.log("clicked blue")
                    mouse.accepted = false
                }
                onDoubleClicked: {
                    console.log("onDoubleClicked")
                }
            }
        }
    }



    MouseArea{
        id: mouseArea
        width: 200
        height: 200
        cursorShape: Qt.CrossCursor // 十字鼠标
        hoverEnabled: true  // 悬停
        onHoveredChanged: {
            console.log("onHoveredChanged")
        }

        // 长按触发  默认800ms
        pressAndHoldInterval: 800
        onPressAndHold: {
            console.log("onPressAndHold")
        }

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        Rectangle{
            anchors.fill: parent
            color: "black"
        }
        onClicked: {
            console.log("click", )
        }
        // hoverEnabled 为true的时候会触发
        onContainsMouseChanged: {
            console.log("onContainsMouseChanged", containsMouse)
        }
        onContainsPressChanged: {
            console.log("onContainsPressChanged", containsPress)
        }

//        onPressed: {
//            var ret = pressedButtons & Qt.LeftButton
//            var ret2 = pressedButtons & Qt.RightButton
//            console.log(ret ? "left" : ret2 ? "right" : "other")
//            console.log("Pressed")
//        }
//        onReleased: {
//            console.log("Released")
//        }
    }
}

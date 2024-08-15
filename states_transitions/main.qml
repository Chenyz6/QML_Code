import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle{
        id: root
        width: 100; height: 100
        state: "blue_color"
        states: [
            State {
                name: "red_color"
                PropertyChanges { target: root; color: "red"; width:200}
            },
            State {
                name: "blue_color"
                PropertyChanges { target: root; color: "blue"; width:300}
            }
        ]
        MouseArea{
            anchors.fill: parent
            onPressed: {
                root.state = "red_color"
            }
            onReleased: {
                root.state = "blue_color"
            }
        }

        // 过渡效果
        transitions: [
            Transition {
                from: "red_color"
                to: "blue_color"

                ColorAnimation {
                    target: root
                    duration: 1000
                }

            },
            Transition {
                from: "blue_color"
                to: "red_color"
                ColorAnimation {
                    target: root
                    duration: 1000
                }
            }
        ]
    }

    Rectangle{
        id: roflashingblob
        width: 75; height: 75
        y: 200
        color: "blue"
        opacity: 1.0
        MouseArea{
            anchors.fill: parent
            onClicked: {
                animateColor.start()
                animateOpacity.start()
                animateWidth.start()
            }
        }

        // animation 动画
        PropertyAnimation{
            id: animateColor;
            target: roflashingblob;
            properties: "color";
            to: "green";
            duration: 1000
        }

        NumberAnimation{
            id: animateOpacity;
            target: roflashingblob;
            properties: "opacity";
            from: 0.1
            to: 1.0
            duration: 2000
        }

        NumberAnimation{
            id: animateWidth;
            target: roflashingblob;
            properties: "width";
            from: 75
            to: 150
            duration: 2000
        }
    }

    Rectangle{
        id: childrenRect
        width: 100; height: 100
        y: 400
        color: "red"
        PropertyAnimation on x { // 修改当前控件的位置
            to: 100
            duration: 2000
        }
        PropertyAnimation on y {
            to: 100
            duration: 2000
        }
        PropertyAnimation on width {
            to: 300
            duration: 2000
        }
    }

    Rectangle{
        width: 100
        height: 100
        color: "red"
        x: 300
        y: 200
        // Sequential  连续的
        SequentialAnimation on color{  // on 直接执行

            ColorAnimation {
                to: "yellow"
                duration: 1000
            }

            ColorAnimation {
                to: "blue"
                duration: 1000
            }
        }
    }
}

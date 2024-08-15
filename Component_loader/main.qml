import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // Component  组件
    Component.onCompleted: {
        console.log("onComponent", width, height, color)
    }
    Component.onDestruction: {
        console.log("onDestruction")
    }

    // Component 只能包含一个根元素
//    Component{
//        id: com
//        Rectangle{
//            width: 100
//            height: 200
//            color: "black"
//        }
//    }

    Component{
        id: com
        Image {
            id: img
            source: "plane.png"
            // 调整大小
//            width: 50
//            height: 50
        }
//        AnimatedImage{
//            id: img
//            width: 50
//            height: 50
//            source: "fire.gif"
//            speed: 10
//        }
    }

    Button{
        id: button
        width: 50
        height: 50
        x: 250; y:250
        onClicked: {
//            loader.sourceComponent = null;
            loader.item.width = 50
            loader.item.height = 50
            loader.item.color = "red"
        }
    }

    Loader{
        id: loader
//        source: "MyRectangle.qml"
        asynchronous: true  // asynchronous 异步的
        sourceComponent: com
        onStatusChanged: {
            console.log("status: ", status)
        }
    }
}

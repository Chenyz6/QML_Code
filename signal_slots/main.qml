import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // 第一种方式  不推荐用
//    signal testSig(string s, int value)
//    function func(ss, ii){
//        console.log(ss, ii)
//    }

    Button{
        width: 50
        height: 50
        onClicked: {
            testSig("zhangsan", 50)
        }
    }

//    Component.onCompleted: {
//        testSig.connect(func)
//    }

    // 第二种方式
    signal testSig(string s, int value)
    Connections{
        target: window
//        onTestSig:{
//            console.log(s, value)
//        }
        function onTestSig(str, iValue){
            console.log(str, iValue)
        }
    }

    Component{
        id: com
        Button{
            id: btn
            width: 100
            height: 50
            background: Rectangle{
                anchors.fill: parent
                border.color: btn.activeFocus ? "blue" : "black"
            }

            signal btnSig(int value)
            onClicked: {
//                console.log("123")
                btnSig(10)
            }
            signal leftButtonPressed()
            Keys.onLeftPressed: {
                leftButtonPressed()
            }
        }
    }

    MyComponent{
        com1: com
        com2: com
    }

}

import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import MyObj 1.0

Window {
    id: window
    width: SCREEN_WIDTH         // 动态绑定 ：的方式改变也会随之改变
    height: 480
    property int value: MyObject.iValue
    objectName: "window"
    // 获取屏幕大小
//    width: Screen.desktopAvailableWidth
//    height: Screen.desktopAvailableHeight
    visible: true
    title: qsTr("Hello World")

    signal qmlSig(int i , string s)

    function qmlSlot(i, s){
        console.log("qml", i, s)
    }

    function qmlFunc(i, s){
        return "success"
    }

    Button{
        x: 200
        y: 200
        width: 100
        height: 100
        objectName: "mybutton"
        onClicked: {
//            myobject.func()
            qmlSig(100, "lisi")
        }
    }

    Button{
        x: 300
        y: 400
        width: 100
        height: 100
        objectName: "mybutton1"
        onClicked: {
            myobject.cppSig(99, "lisi")
        }
    }

    MyRectangle{
        Component.onCompleted: {
            attr.testValue = 100
        }
    }

    MyObject{
        id: myobject
        iValue: width
        sString: "zhangsan"
        Component.onCompleted: {
            console.log(iValue, sString)
        }
    }

    // 第一种方式 通过访问函数实现
    Connections{
        target: window
        function onQmlSig(i, s){
            myobject.cppSlot(i,s);
        }
    }

    Connections{  // 第一种方式c++发送信号qml接受
        target: myobject
        function onCppSig(i, s){
            qmlSlot(i,s)
        }
    }

    // 第二种方式
    Component.onCompleted: {
        qmlSig.connect(myobject.cppSlot)
        value = width
    }

    // 静态绑定 不会改变值
//    Component.onCompleted: {
//        value = width
//    }

    onWidthChanged: {
        console.log(value)
    }
}

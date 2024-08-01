import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml 2.15

Window {    // root控件  父窗口是主界面
    width: 640
    height: 480
    color: white
    visible: true   // 是否显示
    title: qsTr("Hello World")

    // 距离左上角位置 相对于父控件
//    x: 500
//    y: 500

    // 限定大小
//    minimumWidth: 400
//    minimumHeight: 400
//    maximumWidth: 800
//    maximumHeight: 800

    // 不透明度   0-1
//    opacity: 0.5

    // 触发槽函数  on+大写首字母
    onWidthChanged: {
        console.log("width:", width)
    }
    onHeightChanged: {
        console.log("height:", height)
    }

    // 自定义信号与槽函数
//    property int myValue: 0
//    onMyValueChanged: {
//        console.log("myValue:", myValue)
//    }

    // 按钮
    Button{
        id: btn1
        width: 50
        height: 50
        focus: true
        objectName: "btn1"
        background: Rectangle{
            border.color: btn1.focus ? "blue" : "black"
        }
        onClicked: {
            console.log("btn1 clicked")
        }
        Keys.onRightPressed: {
            btn2.focus = true
        }
    }

    Button{
        id: btn2
        x: 200
        width: 50
        height: 50
        objectName: "btn2"
        background: Rectangle{
            border.color: btn2.focus ? "blue" : "black" // border 边框
        }
        onClicked: {
            console.log("btn2 clicked")
        }
        Keys.onLeftPressed: {
            btn1.focus = true
        }
    }

    // 获取焦点控制控件
    onActiveChanged: {
        console.log("active focus item changed", activeFocusItem)
    }

    // 矩形
    Rectangle {
        id: rec1
        x: 100
        y: 100
        z: 1    // 层级 默认为0
        width: 100
        height: 50
        color: "yellow"
        focus: true
//        anchors.centerIn: parent
//        anchors.verticalCenter: parent.verticalCenter
        // activeFocus:
//        anchors.fill: parent    // 锚点 填充在某个控件中
        rotation: 30    // 旋转角度
        scale: 2        // 放大比例
        antialiasing:true   // 抗锯齿 默认true
        border.width: 2 // 边框宽度(主宽度高度不变 占用内部空间)
        border.color: "red"   // 边框颜色
        radius: 10  // 调整矩形圆角
    }

    Rectangle {
        id: rec2
        x: 400
        y: 200
        width: 100
        height: 50
        anchors.top: rec1.button
        anchors.leftMargin: 20
        color: "blue"
    }

    Rectangle {
        id: rec3
        x: 300
        y: 200
        height: 80
        width: 80
        gradient: Gradient{
            GradientStop { position: 0.0; color: "light steelblue" }
            GradientStop { position: 1.0; color: "blue" }
        }
    }

    MyRectangle{
        y: 300
        x: 50
        myTopMargin: 10
        myButtomMargin: 10
    }
}

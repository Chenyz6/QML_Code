import QtQuick 2.0
import QtQuick.Window 2.12

Rectangle{
    width: 200
    height: 100
    color: "black"

    property alias attr: attributes


    // 内部私有化的对象
    QtObject{
        id: attributes
        property int testValue: 0
    }

    Component.onCompleted: {
        console.log(attributes.testValue)
    }
}

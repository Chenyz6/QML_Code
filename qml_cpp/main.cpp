#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>
#include <QScreen>
#include "myobject.h"
#include <QObject>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // 全局对象  上下文对象
    QQmlContext* context = engine.rootContext();
    QScreen* screen = QGuiApplication::primaryScreen();
    QRect rect = screen->virtualGeometry();

    // 注册的上下文对象 它是作用于全局
    context->setContextProperty("SCREEN_WIDTH", 800);  // 会有重名被隐藏的问题
//    context->setContextProperty("MyObject", MyObject::getInstance());   // 第一种方法

    // 我们一定要通过创建对象来定义一个我们自定义的object
    qmlRegisterType<MyObject>("MyObj", 1, 0, "MyObject");           // 第二种方法 推荐使用

//    qmlRegisterSingletonInstance("MyObj", 1, 0, "MyObject", MyObject::getInstance()); // 单例的模式

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // 第三种方法  engine 加载完成后 load以后
    auto list = engine.rootObjects();
//    auto window = list.first()->objectName();
    auto window = list.first();
    auto buttonObj = list.first()->findChild<QObject*>("mybutton");
    qDebug() << buttonObj;
    QObject::connect(window, SIGNAL(qmlSig(int, QString)),
                                    MyObject::getInstance(), SLOT(cppSlot(int, QString)));

//    QObject::connect(MyObject::getInstance(), SIGNAL(cppSig(QVarient, QVarient)),
//                                    window, SLOT(qmlSlot(QVarient, QVarient)));

    // C++端调用qml函数
    QVariant res;
    QVariant arg1 = 123;
    QVariant arg2 = "zhangsan ";
    QMetaObject::invokeMethod(window, "qmlFunc",
                              Q_RETURN_ARG(QVariant, res),
                              Q_ARG(QVariant, arg1), Q_ARG(QVariant, arg2));
    qDebug() << res;

    return app.exec();
}

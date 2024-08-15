#include "myobject.h"

MyObject::MyObject(QObject *parent) : QObject(parent)
{
    // 获取改变的值
//    QTimer* timer = new QTimer;
//    connect(timer, &QTimer::timeout, this, [=](){
//        qDebug() << m_iValue;
//    });
//    timer->start(1000);
}

MyObject *MyObject::getInstance()
{
    static MyObject* obj = new MyObject;
    return obj;
}

int MyObject::iValue() const
{
    return m_iValue;
}

void MyObject::setIValue(int iValue)
{
    m_iValue = iValue;
}

QString MyObject::sString() const
{
    return m_sString;
}

void MyObject::setSString(const QString &sString)
{
    m_sString = sString;
}

void MyObject::func()
{
    qDebug() << __FUNCTION__;
}

void MyObject::cppSlot(int i, QString s)
{
    qDebug() << __FUNCTION__;
    qDebug() << i;
    qDebug() << s;
}

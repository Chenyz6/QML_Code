#ifndef MYOBJECT_H
#define MYOBJECT_H

#include <QObject>
#include <QtQml>

class MyObject : public QObject
{
    Q_OBJECT

    QML_ELEMENT     // qml的一个元素
public:
    explicit MyObject(QObject *parent = nullptr);

    static MyObject* getInstance();

    int iValue() const;
    void setIValue(int iValue);

    QString sString() const;
    void setSString(const QString &sString);

    Q_INVOKABLE void func();

signals:
    void iValueChanged();
    void sStringChanged();

    void cppSig(QVariant i, QVariant s);

public slots:
    void cppSlot(int i, QString s);

private:
    int m_iValue;
    QString m_sString;

//    Q_PROPERTY(int iValue READ iValue WRITE setIValue NOTIFY iValueChanged)
    Q_PROPERTY(int iValue MEMBER m_iValue NOTIFY iValueChanged)
    Q_PROPERTY(QString sString READ sString WRITE setSString NOTIFY sStringChanged)

};

#endif // MYOBJECT_H

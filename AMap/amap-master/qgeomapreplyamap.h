#ifndef QGEOMAPREPLYAMAP_H
#define QGEOMAPREPLYAMAP_H

#include <QtNetwork/QNetworkReply>
#include <QtLocation/private/qgeotilespec_p.h>
#include <QtLocation/private/qgeotiledmapreply_p.h>
#include <QtCore/QPointer>
#include <QFile>
#include <QDir>

QT_BEGIN_NAMESPACE

class QGeoMapReplyAmap : public QGeoTiledMapReply
{
    Q_OBJECT

public:
    QGeoMapReplyAmap(QNetworkReply *reply, const QGeoTileSpec &spec, QObject *parent = 0);
    ~QGeoMapReplyAmap();

    void abort();
    void ReadFileLocation();    // 从本地读取文件

    QNetworkReply *networkReply() const;

private Q_SLOTS:
    void networkFinished();
    void networkError(QNetworkReply::NetworkError error);

private:
    QPointer<QNetworkReply> m_reply;

    int x = 0;      // 第二层级
    int y = 0;      // 第三层级
    int z = 0;      // 第一层级
};

QT_END_NAMESPACE

#endif

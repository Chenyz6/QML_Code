#include "qgeomapreplyamap.h"
#include <QNetworkAccessManager>
#include <QNetworkCacheMetaData>
#include <QDateTime>

QT_BEGIN_NAMESPACE

QGeoMapReplyAmap::QGeoMapReplyAmap(QNetworkReply *reply, const QGeoTileSpec &spec, QObject *parent)
        : QGeoTiledMapReply(spec, parent),
        m_reply(reply)
{
    x = spec.x();
    y = spec.y();
    z = spec.zoom();
    connect(m_reply,
            SIGNAL(finished()),
            this,
            SLOT(networkFinished()));

    connect(m_reply,
            SIGNAL(error(QNetworkReply::NetworkError)),
            this,
            SLOT(networkError(QNetworkReply::NetworkError)));
}

QGeoMapReplyAmap::~QGeoMapReplyAmap()
{
}

QNetworkReply *QGeoMapReplyAmap::networkReply() const
{
    return m_reply;
}

void QGeoMapReplyAmap::abort()
{
    if (!m_reply)
        return;

    m_reply->abort();
}

// 从本地读取文件
void QGeoMapReplyAmap::ReadFileLocation()
{
    QString path = QDir::homePath() + "/roadmap/";
    path += QString::number(z); path += "/";
    path += QString::number(x); path += "/";
    path += QString::number(y); path += ".png"; // 拼接路径层级
    QByteArray imageData;
    QFile file(path);
    if (!file.exists()) {
        qDebug() << "file not exist";
    }else{
        // 打开文件
        if(file.open(QIODevice::ReadOnly)){
            imageData = file.readAll();
            file.close();
            setMapImageData(imageData);
        }else{ // 打开文件失败
            qDebug() << "open file error!";
        }
    }
}

// 从网络中读取文件内容
void QGeoMapReplyAmap::networkFinished()
{
    if (!m_reply)
    {
        ReadFileLocation();  // 从本地读取文件
        return;
    }

    if (m_reply->error() != QNetworkReply::NoError)
    {
        ReadFileLocation();  // 从本地读取文件
        return;
    }

    setMapImageData(m_reply->readAll());

    const int _mid = tileSpec().mapId();
    if (_mid == 2)
        setMapImageFormat("jpeg");
    else
        setMapImageFormat("png");
    setFinished(true);

    m_reply->deleteLater();
    m_reply = 0;
}

void QGeoMapReplyAmap::networkError(QNetworkReply::NetworkError error)
{
    Q_UNUSED(error);
    if (!m_reply)
        return;

    setFinished(true);
    setCached(false);
    m_reply->deleteLater();
    m_reply = 0;
}

QT_END_NAMESPACE

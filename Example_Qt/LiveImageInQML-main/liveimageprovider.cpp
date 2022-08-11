#include "liveimageprovider.h"

LiveImageProvider::LiveImageProvider(QObject *parent)
    : QObject(parent)
    , QQuickImageProvider(QQuickImageProvider::Image)
    ,image(900, 500, QImage::Format_RGB32)
{
    m_socket = new QUdpSocket(this);
    m_socket->bind(QHostAddress("192.168.1.154"), 9999);
    connect(m_socket, &QUdpSocket::readyRead, this, &LiveImageProvider::readDatagrams);
//    image = QImage(900, 500, QImage::Format_RGB32);
//    image.fill(Qt::magenta);
}

void LiveImageProvider::readDatagrams()
{
    //while (m_socket->hasPendingDatagrams()) {
        //QNetworkDatagram datagram = m_socket->receiveDatagram();
        QByteArray Buffer;
        Buffer.resize(m_socket->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;
        m_socket->readDatagram(Buffer.data(),Buffer.size(),&sender, &senderPort);
        //image.loadFromData(Buffer,"jpg");
        //QByteArray txt = "iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAADxSURBVFhH7ZSxDYMwEEW9RdqU9MhFOho6WrwAE0SsESGlyABpvEU2yB5ZItLFnG1kkJEgipUjuSdZWG78+HdnwTAMAR73J7gtXTYjOSd61Wc6PxCTJCXYM5X8muDldJi9OJQkKdjj+5KsoGcTgrHhSc5PJei2iVA1qNvRrBoyIYbLiAjmUBi5Sjc0BbPOJKdL2LVG0HzdMbJEMG16WNoGpBQUBW1pC2VLikl2OR3BqRAtQSzteCBigkv4vKAsoQpK65HaTHK7JyA4vHnxtVYy4ZCEjAdmDSyIYF/a99CdLCaxoE0u7MF3UmQYhmGYv0SIF0Zn9rmd3QoAAAAAAElFTkSuQmCC";

        QImage newimage;
        newimage.loadFromData(QByteArray::fromBase64(Buffer),"jpg");
        image = newimage;
        emit imageChanged();
        //image2 = setPixmap(image);
        //ui->label->setPixmap(image);
        //qDebug() << Buffer.toBase64().data();
        qDebug() << Buffer.toBase64();
   // }
}
QImage LiveImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(id);

    if (size) {
        *size = image.size();
    }

    if (requestedSize.width() > 0 && requestedSize.height() > 0) {
        image = image.scaled(requestedSize.width(), requestedSize.height(), Qt::KeepAspectRatio);
    }

    return image;
}

void LiveImageProvider::updateImage(const QImage &image, bool checkTheSame)
{
    if (image.isNull())
        return;

    if (checkTheSame && (this->image != image))
        return;

    this->image = image;
   // emit imageChanged();
}

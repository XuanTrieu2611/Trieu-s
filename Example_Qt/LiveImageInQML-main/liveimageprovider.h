#ifndef LIVEIMAGEPROVIDER_H
#define LIVEIMAGEPROVIDER_H

#include <QObject>
#include <QQuickImageProvider>
#include <QUdpSocket>

class LiveImageProvider : public QObject, public QQuickImageProvider
{
    Q_OBJECT
public:
    LiveImageProvider(QObject *parent = nullptr);

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

public slots:
    void updateImage(const QImage &image, bool checkTheSame = false);
    void readDatagrams();
signals:
    void imageChanged();

private:
    QImage image;
    QUdpSocket *m_socket;
};

#endif // LIVEIMAGEPROVIDER_H

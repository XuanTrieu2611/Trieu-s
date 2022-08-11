#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    m_socket = new QUdpSocket(this);
    m_socket->bind(QHostAddress("192.168.1.3"), 9999);
    connect(m_socket, &QUdpSocket::readyRead, this, &MainWindow::readDatagrams);
}

MainWindow::~MainWindow()
{
    delete ui;
}
void MainWindow::readDatagrams()
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

        //QPixmap image;
        image.loadFromData(QByteArray::fromBase64(Buffer),"jpg");
        ui->label->setPixmap(image);
        //ui->label->setPixmap(image);
        //qDebug() << Buffer.toBase64().data();
        qDebug() << Buffer.toBase64();
   // }
}



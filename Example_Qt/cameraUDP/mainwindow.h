#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QObject>
#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QPixmap>
#include <QBuffer>
#include <QImage>
QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:
    void readDatagrams();

private:
    Ui::MainWindow *ui;
    QUdpSocket *m_socket;
    QPixmap image;
    QImage image2;
};
#endif // MAINWINDOW_H

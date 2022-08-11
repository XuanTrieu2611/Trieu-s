#ifndef UDP_H
#define UDP_H

#include <QObject>
#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QPointF>
#include <QTimer>
#include <QtCore/QObject>
#include <QtCore/QTimer>

//QT_BEGIN_NAMESPACE
//class QGamepad;
//QT_END_NAMESPACE

class UDP : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double udproll READ getudproll NOTIFY rollChange)
    Q_PROPERTY(double udppitch READ getudppitch NOTIFY pitchChange)
    Q_PROPERTY(double udpyaw READ getudpyaw NOTIFY yawChange)
    Q_PROPERTY(double udpvoltage READ getudpvoltage NOTIFY voltageChange)
    Q_PROPERTY(double udpcurrent READ getudpcurrent NOTIFY currentChange)
    Q_PROPERTY(double udpbattery READ getudpbattery NOTIFY batteryChange)
    Q_PROPERTY(double accX READ getaccX NOTIFY accXChange)
    Q_PROPERTY(double accY READ getaccY NOTIFY accYChange)
    Q_PROPERTY(double pwmEngineLeft READ getpwmEngineLeft NOTIFY pwmEngineLeftChange)
    Q_PROPERTY(double pwmEngineRight READ getpwmEngineRight NOTIFY pwmEngineRightChange)
    Q_PROPERTY(double distance READ getdistance NOTIFY distanceChange)
    Q_PROPERTY(double confidence READ getconfidence NOTIFY confidenceChange)
    Q_PROPERTY(double power READ getpower NOTIFY powerChange)
    Q_PROPERTY(double gpslongitude READ getgpslongitude NOTIFY gpsChange)
    Q_PROPERTY(double gpslatitude READ getgpslatitude NOTIFY gpsChange)
    Q_PROPERTY(double headingmap READ getheadingmap NOTIFY gpsChange)
    Q_PROPERTY(double nextlatitude READ getnextlatitude NOTIFY gpsChange)
    Q_PROPERTY(double nextlongitude READ getnextlongitude NOTIFY gpsChange)
    Q_PROPERTY(double distancetoNP READ getdistancetoNP NOTIFY gpsChange)
    Q_PROPERTY(double speed READ getSpeed NOTIFY gpsChange)

    Q_PROPERTY(QPointF getplotRoll READ getplotRoll NOTIFY plotChange)
    Q_PROPERTY(QPointF getplotPitch READ getplotPitch NOTIFY plotChange)
    Q_PROPERTY(QPointF getplotDistance READ getplotDistance NOTIFY plotChange)
    Q_PROPERTY(QPointF getplotAccX READ getplotAccX NOTIFY plotChange)
    Q_PROPERTY(QPointF getplotAccY READ getplotAccY NOTIFY plotChange)

public:
    explicit UDP(QObject *parent = Q_NULLPTR);
    double getudproll();
    double getudppitch();
    double getudpyaw();
    double getudpvoltage();
    double getudpcurrent();
    double getudpbattery();
    double getaccX();
    double getaccY();
    double getpwmEngineLeft();
    double getpwmEngineRight();
    double getdistance();
    double getconfidence();
    double getpower();
    double getgpslongitude();
    double getgpslatitude();
    double getheadingmap();
    double getnextlatitude();
    double getnextlongitude();
    double getdistancetoNP();
    double getSpeed();

    QPointF getplotRoll();
    QPointF getplotPitch();
    QPointF getplotDistance();
    QPointF getplotAccX();
    QPointF getplotAccY();

    QHostAddress getIp();
    int getPort();
    Q_INVOKABLE void setIp(QString newIp);
    Q_INVOKABLE void setPort(int newPort);
    Q_INVOKABLE void start(); 
    Q_INVOKABLE void udpHeadLightOn(bool stateHeadLight);
    Q_INVOKABLE void autoModeOn();
    Q_INVOKABLE void joystickModeOn();
signals:
    void rollChange();
    void pitchChange();
    void yawChange();
    void accXChange();
    void accYChange();
    void pwmEngineLeftChange();
    void pwmEngineRightChange();
    void voltageChange();
    void currentChange();
    void batteryChange();
    void plotChange();
    void distanceChange();
    void confidenceChange();
    void powerChange();
    void gpsChange();

public slots:
    void readDatagrams();
    void readDatagrams1();

private slots:
    void wTimeout();
    void gpsTimeout();
private:
    QUdpSocket *m_socket;
    QUdpSocket *m_socket1;
    QUdpSocket *m_socketsend;

    double m_currentRoll  ;
    double m_currentPitch ;
    double m_currentYaw = 0 ;
    double m_accX ;
    double m_accY ;
    double m_pwmEngineLeft ;
    double m_pwmEngineRight ;
    double m_currentVoltage ;
    double m_currentCurrent ;
    double m_currentBattery ;
    double m_distance ;
    double m_confidence ;
    double m_power;
    double m_gpslatitude ;
    double m_gpslongitude;
    double m_nextlatitude;
    double m_nextlongtitude;
    double m_distancetoNP;

    double m_gpslatitudecalculateV;
    double m_gpslongitudecalculateV;

    QPointF m_plotRoll;
    QPointF m_plotPitch;
    QPointF m_plotDistance;
    QPointF m_plotAccX;
    QPointF m_plotAccY;

    QTimer *m_Timer;
    QTimer *m_gpsTimer;

    QHostAddress m_Ip;

//    QGamepad *m_gamepad;

    int m_Port;
};

#endif // UDP_H

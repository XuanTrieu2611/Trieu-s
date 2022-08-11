#include "udp.h"
#include <QDebug>
#include <math.h>
#include <QtGamepad/QGamepad>

#include <QDebug>
#include <QLoggingCategory>
UDP::UDP(QObject *parent)
    : QObject{parent}, m_socket(nullptr)
    ,m_socket1(nullptr)
    ,m_socketsend(nullptr)
    ,m_currentRoll(0)
    ,m_currentPitch(0)
    ,m_currentYaw(0)
    ,m_accX(0)
    ,m_accY(0)
    ,m_pwmEngineLeft(0)
    ,m_pwmEngineRight(0)
    ,m_currentVoltage(0)
    ,m_currentCurrent(0)
    ,m_currentBattery(0)
    ,m_distance(0)
    ,m_confidence(0)
    ,m_power(0)
    ,m_gpslatitude(0)
    ,m_gpslongitude(0)
    ,m_nextlatitude(0)
    ,m_nextlongtitude(0)
    ,m_gpslatitudecalculateV(0)
    ,m_gpslongitudecalculateV(0)
    ,m_Ip("192.168.1.154")
    //    ,m_gamepad(0)
    ,m_Port(5005)
{

    //    m_socket = new QUdpSocket(this);
    //    m_socket->bind(QHostAddress(getIp()), getPort());
    //    connect(m_socket, &QUdpSocket::readyRead, this, &UDP::readDatagrams);

    //    m_Timer = new QTimer(this);
    //    m_Timer->setInterval((500));
    //    connect(m_Timer, &QTimer::timeout, this, &UDP::wTimeout);
    //    m_Timer->start();

    //    m_Timer1 = new QTimer(this);
    //    m_Timer1->setInterval((500));
    //    connect(m_Timer1, &QTimer::timeout, this, &UDP::wTimeout1);
    //    m_Timer1->start();

    //    QLoggingCategory::setFilterRules(QStringLiteral("qt.gamepad.debug=true"));

    //    auto gamepads = QGamepadManager::instance()->connectedGamepads();
    //    if (gamepads.isEmpty()) {
    //        qDebug() << "Did not find any connected gamepads";
    //        return;
    //    }

    //    m_gamepad = new QGamepad(*gamepads.begin(), this);
    //    connect(m_gamepad, &QGamepad::axisLeftXChanged, this, [](double value){
    //        qDebug() << "Left X" << 100*value;
    //    });
    //    connect(m_gamepad, &QGamepad::axisLeftYChanged, this, [](double value){
    //        qDebug() << "Left Y" << 100*value;
    //    });
}
Q_INVOKABLE void UDP::start()
{
    m_socket = new QUdpSocket(this);
    m_socket->bind(QHostAddress(getIp()), getPort());
    connect(m_socket, &QUdpSocket::readyRead, this, &UDP::readDatagrams);

    m_socket1 = new QUdpSocket(this);
    m_socket1->bind(QHostAddress(getIp()), getPort()+3);
    connect(m_socket1, &QUdpSocket::readyRead, this, &UDP::readDatagrams1);

    m_socketsend = new QUdpSocket(this);

    m_Timer = new QTimer(this);
    m_Timer->setInterval((1000));
    connect(m_Timer, &QTimer::timeout, this, &UDP::wTimeout);
    m_Timer->start();

    m_gpsTimer = new QTimer(this);
    m_gpsTimer->setInterval(2000);
    connect(m_gpsTimer, &QTimer::timeout, this, &UDP::gpsTimeout);
    m_gpsTimer->start();


}

void UDP::udpHeadLightOn(bool stateHeadLight)
{
    QString str;

    if(stateHeadLight == true){
        str ="HeadLightOn" ;
    }else{
        str = "HeadLightOff";
    }
    QByteArray datagram = str.toUtf8();
    m_socket->writeDatagram(datagram, QHostAddress(getIp()), getPort()+2);
}

void UDP::autoModeOn()
{
    QString str ="Auto";
    QByteArray datagram = str.toUtf8();
    m_socket->writeDatagram(datagram, QHostAddress(getIp()), getPort()+2);

}

void UDP::joystickModeOn()
{
    QString str ="Joystick";
    QByteArray datagram = str.toUtf8();
    m_socket->writeDatagram(datagram, QHostAddress(getIp()), getPort()+2);
}


void UDP::wTimeout(){
    m_plotRoll.setX(m_plotRoll.x()+1);
    m_plotRoll.setY(getudproll());
    m_plotPitch.setY(getudppitch());
    m_plotDistance.setX(m_plotDistance.x()+1);
    m_plotDistance.setY(getdistance());
    m_plotAccX.setX(m_plotAccX.x()+1);
    m_plotAccX.setY(getaccX());
    m_plotAccY.setY(getaccY());


    emit plotChange();
    emit accXChange();
    emit accYChange();
    emit pwmEngineRightChange();
    emit pwmEngineLeftChange();
    emit voltageChange();
    emit currentChange();
    emit batteryChange();
    emit distanceChange();
    emit confidenceChange();
    emit powerChange();

}

void UDP::gpsTimeout()
{
    emit gpsChange();
}
void UDP::readDatagrams()
{

    while (m_socket->hasPendingDatagrams()) {
        QNetworkDatagram datagram = m_socket->receiveDatagram();
        bool ok = true;
        std::string str = datagram.data().toStdString();
        const QString str2 = QString::fromStdString(str);
        QStringList list2 = str2.split(QLatin1Char(','), Qt::SkipEmptyParts);
        double newRoll = list2[0].toDouble(&ok);
        double newPitch = list2[1].toDouble(&ok);
        double newYaw = list2[2].toDouble(&ok);
        double newAccX = list2[3].toDouble(&ok);
        double newAccY = list2[4].toDouble(&ok);
        double newpwmEngineLeft = list2[5].toDouble(&ok);
        double newpwmEngineRight = list2[6].toDouble(&ok);
        double newdistance = list2[7].toDouble(&ok);
        double newconfidence = list2[8].toDouble(&ok);
        if (ok && m_currentRoll != newRoll) {
            m_currentRoll = newRoll;
            emit rollChange();
        }
        if (ok && m_currentPitch != newPitch) {
            m_currentPitch = newPitch;
            emit pitchChange();
        }
        if (ok && m_currentYaw != newYaw) {
            m_currentYaw = newYaw;
            emit yawChange();
        }
        if (ok && m_accX != newAccX) {
            m_accX = newAccX;
        }
        if (ok && m_accY != newAccY) {
            m_accY= newAccY;

        }
        if (ok && m_pwmEngineLeft != newpwmEngineLeft) {
            m_pwmEngineLeft = newpwmEngineLeft;

        }
        if (ok && m_pwmEngineRight != newpwmEngineRight) {
            m_pwmEngineRight = newpwmEngineRight;

        }

        if (ok && m_distance != newdistance) {
            m_distance = newdistance;

        }
        if (ok && m_confidence != newconfidence) {
            m_confidence = newconfidence;

        }
    }
}

void UDP::readDatagrams1()
{
    while (m_socket1->hasPendingDatagrams()) {
        QNetworkDatagram datagram = m_socket1->receiveDatagram();
        bool ok = true;
        std::string str = datagram.data().toStdString();
        const QString str1 = QString::fromStdString(str);
        QStringList list = str1.split(QLatin1Char(','), Qt::SkipEmptyParts);
        double newVoltage = list[0].toDouble(&ok);
        double newCurrent = list[1].toDouble(&ok);
        double newPower = list[2].toDouble(&ok);
        double newgpslatitude = list[3].toDouble(&ok);
        double newgpslongitude = list[4].toDouble(&ok);
        double newnextlatitude = list[5].toDouble(&ok);
        double newnextlongitude = list[6].toDouble(&ok);
        if (ok && m_currentVoltage != newVoltage) {
            m_currentVoltage = newVoltage;
        }
        if (ok && m_currentCurrent != newCurrent) {
            m_currentCurrent = newCurrent;
        }
        if (ok && m_power != newPower) {
            m_power = newPower;
        }
        if (ok && m_gpslongitude != newgpslongitude) {
            m_gpslongitudecalculateV = newgpslongitude - m_gpslongitude ;
            m_gpslongitude = newgpslongitude;
            qDebug()<<m_gpslongitudecalculateV;
        }
        if (ok && m_gpslatitude != newgpslatitude) {
            m_gpslatitudecalculateV = newgpslatitude - m_gpslatitude;
            m_gpslatitude = newgpslatitude;
        }
        if (ok && m_nextlongtitude != newnextlongitude) {
            m_nextlongtitude = newnextlongitude;
        }
        if (ok && m_nextlatitude != newnextlatitude) {
            m_nextlatitude = newnextlatitude;
        }
    }
}

double UDP::getudproll()
{
    return m_currentRoll;

}

double UDP::getudppitch()
{
    return m_currentPitch;
}

double UDP::getudpyaw()
{
    return m_currentYaw;
}

double UDP::getudpvoltage()
{
    return m_currentVoltage;
}

double UDP::getudpcurrent()
{
    return m_currentCurrent;
}

double UDP::getudpbattery()
{
    return m_currentBattery;
}

double UDP::getaccX()
{
    return m_accX;
}

double UDP::getaccY()
{
    return m_accY;
}

double UDP::getpwmEngineLeft()
{
    return m_pwmEngineLeft;
}

double UDP::getpwmEngineRight()
{
    return m_pwmEngineRight;
}

double UDP::getdistance()
{
    return m_distance;
}

double UDP::getconfidence()
{
    return m_confidence;

}

double UDP::getpower()
{
    return m_power;
}

double UDP::getgpslongitude()
{
    return m_gpslongitude;
}

double UDP::getgpslatitude()
{
    return m_gpslatitude;
}

double UDP::getheadingmap()
{
    return m_currentYaw ;
}

double UDP::getnextlatitude()
{
    return m_nextlatitude;
}

double UDP::getnextlongitude()
{
    return m_nextlongtitude;
}

double UDP::getdistancetoNP()
{
    double x=113894*(m_gpslatitude-m_nextlatitude);
    double y=104225*(m_nextlongtitude-m_gpslongitude);
    return m_distancetoNP =round( sqrt(x*x+y*y));
}

double UDP::getSpeed()
{
    double x=113894*m_gpslatitudecalculateV;
    double y=104225*m_gpslongitudecalculateV;
    return round(sqrt(x*x+y*y))/2;

}

QPointF UDP::getplotRoll()
{
    return m_plotRoll;
}
QPointF UDP::getplotPitch()
{
    return m_plotPitch;
}

QPointF UDP::getplotDistance()
{
    return m_plotDistance;
}
QPointF UDP::getplotAccX()
{
    return m_plotAccX;
}
QPointF UDP::getplotAccY()
{
    return m_plotAccY;
}

QHostAddress UDP::getIp()
{
    return m_Ip;
}

int UDP::getPort(){
    return m_Port;
}

Q_INVOKABLE void UDP::setIp(QString newIp)
{
    m_Ip.setAddress(newIp);
}

Q_INVOKABLE void UDP::setPort(int newPort)
{
    if(newPort == m_Port)
        return;
    m_Port = newPort;
}





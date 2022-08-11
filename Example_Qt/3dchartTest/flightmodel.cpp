#include "flightmodel.h"

FlightModel::FlightModel(QObject *parent) : QAbstractListModel(parent)
{
    //    qsrand(time(NULL));
    //    int count = 100 + qrand() % 100;
    //    for(int i = 0;i < count;i ++) {
    //        double x = (double)(qrand() % 1000);
    //        double y = (double)(qrand() % 1000);
    //        double z = (double)(qrand() % 1000);
    //        m_innerData.append(QVector3D(x, y, z));
    m_Timer = new QTimer(this);
    m_Timer->setInterval((2000));
    connect(m_Timer, &QTimer::timeout, this, &FlightModel::wTimeout);
    m_Timer->start();
    //    }
}
void FlightModel::wTimeout(){
    int HIGH = 100;
    int LOW = 0;
    int val = rand() % (HIGH - LOW + 1) + LOW;
    int val1 = rand() % (HIGH - LOW + 3) + LOW;
    int val2 = rand() % (HIGH - LOW + 5) + LOW;
    m_innerData.append(QVector3D(val, val1, val2));
    emit plotRollChanged();
}
int FlightModel::rowCount(const QModelIndex &parent) const
{
    return m_innerData.count();
}

QVariant FlightModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QVariant();

    QVector3D point = m_innerData[index.row()];
    switch(role) {
    case Qt::UserRole + 1: return point.x(); break;
    case Qt::UserRole + 2: return point.y(); break;
    case Qt::UserRole + 3: return point.z(); break;
    }
    return QVariant();
}

QHash<int, QByteArray> FlightModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "x";
    roles[Qt::UserRole + 2] = "y";
    roles[Qt::UserRole + 3] = "z";
    return roles;
}

QList<QVector3D> FlightModel::getplotRoll()
{
    return m_innerData;
}

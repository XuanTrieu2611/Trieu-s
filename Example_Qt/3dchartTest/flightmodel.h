#ifndef FLIGHTMODEL_H
#define FLIGHTMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QVector3D>
#include <QTimer>

class FlightModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QList<QVector3D> getplotRoll READ getplotRoll NOTIFY plotRollChanged)

public:
    FlightModel(QObject *parent = Q_NULLPTR);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    QList<QVector3D> getplotRoll();
signals:
    void plotRollChanged();
private slots:
    void wTimeout();
private:
    QList<QVector3D> m_innerData;
    QTimer * m_Timer;
};

#endif // FLIGHTMODEL_H

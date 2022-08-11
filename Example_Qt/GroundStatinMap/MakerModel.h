#ifndef MAKERMODEL_H
#define MAKERMODEL_H
#include <QAbstractListModel>
#include <QGeoCoordinate>
#include <QDebug>
class MarkerModel : public QAbstractListModel
{
    Q_OBJECT

public:
    //using QAbstractListModel::QAbstractListModel;
    enum MarkerRoles{positionRole = Qt::UserRole + 1,numberHeader=Qt::UserRole + 1};

    Q_INVOKABLE void addMarker(const QGeoCoordinate &coordinate){
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_coordinates.append(coordinate);
        //qDebug() << coordinate;
        endInsertRows();
    }
    Q_INVOKABLE void removeMarker(const int &index){
        beginRemoveRows(QModelIndex(),index, index);
        m_coordinates.removeAt(index);
        endRemoveRows();
    }

    int rowCount(const QModelIndex &parent = QModelIndex()) const override{
        Q_UNUSED(parent)
        return m_coordinates.count();
    }

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override{
        if (index.row() < 0 || index.row() >= m_coordinates.count())
            return QVariant();
        if(role== MarkerModel::positionRole)
            return QVariant::fromValue(m_coordinates[index.row()]);
        return QVariant();
    }

    QHash<int, QByteArray> roleNames() const override{
        QHash<int, QByteArray> roles;
        roles[positionRole] = "position";
        //roles[numberHeader] = "numberHeader";

        //qDebug() << roles;
        return roles;
    }
    Q_INVOKABLE void getList(){
        foreach(auto &x,m_coordinates)
        qDebug() << x;
        qDebug() << " ";
    };
    Q_INVOKABLE int getNumber(const QGeoCoordinate &coordinate){
        int numberRowofValue = m_coordinates.indexOf(coordinate);
        qDebug() <<"getNUmber" <<numberRowofValue+1;
        return numberRowofValue+1;
    };
    Q_INVOKABLE int getLength(){
        int lengthList = m_coordinates.length();
        qDebug()<< "chieu dai LIst: "<< lengthList;
        return lengthList;
    }
    Q_INVOKABLE QGeoCoordinate valueInPosition(int positionRow){
        qDebug()<<"Tai hang"<<positionRow <<  "co Toa do"  <<m_coordinates.value(positionRow);
        return m_coordinates.value(positionRow);
    }

private:
    QList<QGeoCoordinate> m_coordinates;
};


#endif // MAKERMODEL_H

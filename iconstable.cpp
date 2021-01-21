#include "iconstable.h"



IconsTable::IconsTable(QAbstractTableModel *parent) : QAbstractTableModel(parent)
{

}

/*int IconsTable::rowCount(const QModelIndex & = QModelIndex());


int columnCount(const QModelIndex & = QModelIndex()) const override
{
    return 200;
}

QVariant data(const QModelIndex &index, int role) const override
{
    switch (role) {
        case Qt::DisplayRole:
            return QString("%1, %2").arg(index.column()).arg(index.row());
        default:
            break;
    }

    return QVariant();
}

QHash<int, QByteArray> roleNames() const override
{
    return { {Qt::DisplayRole, "display"} };
}
*/

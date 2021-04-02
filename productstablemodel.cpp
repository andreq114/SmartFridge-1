#include "productstablemodel.h"
#include <QDebug>

ProductsTableModel::ProductsTableModel(QObject *parent) : QAbstractTableModel(parent)
{
}

int ProductsTableModel::rowCount(const QModelIndex &parent) const
{
    (void) parent;
    return items.size();

}


int ProductsTableModel::columnCount(const QModelIndex &parent) const
{
    (void) parent;
    return roleNames().size();

}


QVariant ProductsTableModel::data(const QModelIndex &index, int role) const
{
    QVariant variant;
    const int row = index.row();
    const int col = role;
    switch (col){
    case 0:
        variant = items.at(row).description;
        break;
    case 1:
        variant = items.at(row).exp_date;
        break;
    case 2:
        variant = items.at(row).aVisible;
        break;
    case 3:
        variant = *items.at(row).redTerm;
        break;
    case 4:
        variant = *items.at(row).yellowTerm;
        break;
    }
    return variant;
}

bool ProductsTableModel::setData(const QModelIndex &i, const QVariant &value, int) {
    items[i.row()].aVisible = value.toBool();
    emit dataChanged(index(i.row(),2), index(i.row(),2));
    return true;
}

void ProductsTableModel::clear()
{
    items.clear();
    emit endResetModel();
}
QHash<int,QByteArray> ProductsTableModel::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles.insert(0,"description");
    roles.insert(1,"exp_date");
    roles.insert(2,"aVisible");
    roles.insert(3,"redTerm");
    roles.insert(4,"yellowTerm");
    return roles;
}


void ProductsTableModel::addProduct(QString descr, QDate date, bool *redTerm, bool *yellowTerm) {
    items.append({descr,QDateTime(date), false, redTerm, yellowTerm});
}

void ProductsTableModel::sortModel(){
    std::sort(items.begin(), items.end(), [](oneProduct a, oneProduct b) {
            if (a.description < b.description) return true;
             if (a.description > b.description) return false;
             if (a.exp_date < b.exp_date) return true;
             if (a.exp_date > b.exp_date) return false;
             return false;
        });
}

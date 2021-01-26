#include "productstablemodel.h"

ProductsTableModel::ProductsTableModel(QObject *parent) : QAbstractTableModel(parent)
{
    /*itemki.append({"Chocolate Wedel Strawberry 150 g","25.06.2021",});
    itemki.append({"Milka Mleczna Dolina 3.2 1L","25.03.2021",});
    itemki.append({"Beer Warka 6 percent 500 ml","30.12.2021"});
    itemki.append({"Beer Żywiec 6 percent 500 ml","31.12.2021"});
    itemki.append({"Beer Tyskie 6 percent 500 ml","25.12.2021"});
    itemki.append({"Beer Żubr 6 percent 500 ml","30.11.2021"});
    itemki.append({"Beer Zatecky 6 percent 500 ml","30.12.2022"});*/
}

int ProductsTableModel::rowCount(const QModelIndex &parent) const
{
    (void) parent;
    return itemki.size();

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
        variant = itemki.at(row).description;
        break;
    case 1:
        variant = itemki.at(row).exp_date;
        break;

    }
    return variant;



}


QHash<int,QByteArray> ProductsTableModel::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles.insert(0,"description");
    roles.insert(1,"exp_date");

    return roles;
}






void ProductsTableModel::addProduct(QString descr,QString date) {
    itemki.append({descr,date});
}

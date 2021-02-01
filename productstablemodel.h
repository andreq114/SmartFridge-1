#ifndef PRODUCTSTABLEMODEL_H
#define PRODUCTSTABLEMODEL_H

#include <QAbstractTableModel>
#include <QModelIndex>
#include <QHash>
#include <QVariant>
#include <QByteArray>
#include <QList>
#include <qqml.h>
#include "product.h"

const int COLS= 3;
const int ROWS= 2;

struct oneProduct{
    QString description;
    QString exp_date;

};

class ProductsTableModel : public QAbstractTableModel
{
    Q_OBJECT
    Q_PROPERTY(Product::Category category READ getCategory NOTIFY categoryChanged)
public:
    ProductsTableModel(QObject *parent = nullptr);
    Q_INVOKABLE void addProduct(QString descr,QString date);
    Product::Category getCategory() const {return category;}
    void setCategory(Product::Category cat) {category = cat;}
protected:
    Q_INVOKABLE  int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE  int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE  QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE QHash<int,QByteArray> roleNames() const override;
    //Q_INVOKABLE bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    //Qt::ItemFlags flags(const QModelIndex &index) const override;

signals :
    void categoryChanged();

private:
    QList<oneProduct> itemki;
    Product::Category category;
};

#endif // PRODUCTSTABLEMODEL_H

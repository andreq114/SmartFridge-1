#ifndef PRODUCTSTABLEMODEL_H
#define PRODUCTSTABLEMODEL_H

#include <QAbstractTableModel>
#include <QModelIndex>
#include <QHash>
#include <QVariant>
#include <QByteArray>
#include <QList>
#include <qqml.h>

const int COLS= 3;
const int ROWS= 2;

struct oneProduct{
    QString description;
    QString exp_date;

};

class ProductsTableModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    ProductsTableModel(QObject *parent = nullptr);
    void addProduct(QString descr,QString date);
protected:
    Q_INVOKABLE  int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE  int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE  QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE QHash<int,QByteArray> roleNames() const override;
    //Q_INVOKABLE bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    //Qt::ItemFlags flags(const QModelIndex &index) const override;

private:
    QList<oneProduct> itemki;
};

#endif // PRODUCTSTABLEMODEL_H

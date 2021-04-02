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



class ProductsTableModel : public QAbstractTableModel
{
    Q_OBJECT
    Q_PROPERTY(Product::Category category READ getCategory NOTIFY categoryChanged)
public:
    ProductsTableModel(QObject *parent = nullptr);
    Q_INVOKABLE void       addProduct(QString descr, QDate date,  bool *redTerm, bool *yellowTerm);
    Q_INVOKABLE  int       rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Product::Category      getCategory() const {return category;}
    void                   setCategory(Product::Category cat) {category = cat;}
    void                   clear();
    void                   sortModel();

    struct oneProduct{
        QString description;
        QDateTime exp_date;
        bool aVisible;
        bool *redTerm;
        bool *yellowTerm;
    };

signals :
    void                    categoryChanged();

protected:

    Q_INVOKABLE int                     columnCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE QVariant                data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE QHash<int,QByteArray>   roleNames() const override;
    Q_INVOKABLE bool                    setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;


private:
    QList<oneProduct>       items;
    Product::Category       category;
};

#endif // PRODUCTSTABLEMODEL_H

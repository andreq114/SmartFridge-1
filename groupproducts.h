#ifndef GROUPPRODUCTS_H
#define GROUPPRODUCTS_H

#include <QObject>
#include "datatransfer.h"
#include "product.h"

class GroupProducts : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName NOTIFY nameChanged)
    Q_PROPERTY(Product::Category category READ getCategory NOTIFY categoryChanged)
public:
    explicit GroupProducts(QObject *parent = nullptr);

    QString getName() const {return name;}

    Product::Category getCategory() const {return category;}

signals:
    void nameChanged();
    void categoryChanged();
private:
    Product::Category                   category;
    QString                             name;
    QList<Product *>                    products;
};

#endif // GROUPPRODUCTS_H

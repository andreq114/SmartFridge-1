#ifndef GROUPPRODUCTS_H
#define GROUPPRODUCTS_H

#include <QObject>
#include <QQmlListProperty>
#include "datatransfer.h"
#include "product.h"

class GroupProducts : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Product::Category category READ getCategory NOTIFY categoryChanged)
    Q_PROPERTY(QQmlListProperty<Product> products READ Products NOTIFY productsChanged)
public:
    explicit GroupProducts(Product::Category cat, QObject *parent = nullptr);
    GroupProducts(QObject *parent = nullptr);

    static int count_products(QQmlListProperty<Product> *list);
    static Product* at_group(QQmlListProperty<Product> *list, int index);


    //QString getName() const {return name;}
    Product::Category getCategory() const {return category;}
    void addProduct(Product *);
    QQmlListProperty<Product> Products();
    QList<Product *> getProducts();
signals:
    void productsChanged();
    //void nameChanged();
    void categoryChanged();
private:
    Product::Category                   category;
    QList<Product *>                    products;
};

#endif // GROUPPRODUCTS_H

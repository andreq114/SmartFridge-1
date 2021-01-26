#ifndef QMLDATA_H
#define QMLDATA_H

#include <QObject>
#include "groupproducts.h"
#include <QQmlListProperty>

class QMLdata : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<GroupProducts> groupProducts READ getProducts NOTIFY groupProductsChanged)
public:
    explicit QMLdata(QObject *parent = nullptr);
    explicit QMLdata(QVector<Product *> *products, QObject *parent = nullptr);
    QList<GroupProducts *> groupProducts;

    QQmlListProperty<GroupProducts> getProducts();
    static int count_group(QQmlListProperty<GroupProducts> *list);
    static GroupProducts* at_group(QQmlListProperty<GroupProducts> *list, int index);
signals:
    void groupProductsChanged();

private:
    void makeGroups(QVector<Product *> *products);
};

#endif // QMLDATA_H

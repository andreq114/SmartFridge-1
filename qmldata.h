#ifndef QMLDATA_H
#define QMLDATA_H

#include <QObject>
#include "groupproducts.h"
#include <QQmlListProperty>

class QMLdata : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<GroupProducts> products READ getProducts NOTIFY productsChanged)
public:
    explicit QMLdata(QObject *parent = nullptr);
    QList<GroupProducts *> products;

    QQmlListProperty<GroupProducts> getProducts();
    static int count_group(QQmlListProperty<GroupProducts> *list);
    static GroupProducts* at_group(QQmlListProperty<GroupProducts> *list, int index);
signals:
    void productsChanged();
};

#endif // QMLDATA_H

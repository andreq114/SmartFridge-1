#include "qmldata.h"

QMLdata::QMLdata(QObject *parent) : QObject(parent)
{
    products.append(new GroupProducts);
    products.append(new GroupProducts);
}

QQmlListProperty<GroupProducts> QMLdata::getProducts()
{
    return QQmlListProperty<GroupProducts>(this, nullptr, &QMLdata::count_group, &QMLdata::at_group);
}

int QMLdata::count_group(QQmlListProperty<GroupProducts> *list)
{
    QMLdata *msgBoard = qobject_cast<QMLdata *>(list->object);
    return msgBoard->products.size();
}

GroupProducts* QMLdata::at_group(QQmlListProperty<GroupProducts> *list, int index)
{
    QMLdata *msgBoard = qobject_cast<QMLdata *>(list->object);
    return msgBoard->products[index];
}

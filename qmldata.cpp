#include "qmldata.h"

QMLdata::QMLdata(QObject *parent) : QObject(parent)
{
}

QMLdata::QMLdata(QVector<Product *> *products, QObject *parent) : QObject(parent)
{
    makeGroups(products);
}

QQmlListProperty<GroupProducts> QMLdata::getProducts()
{
    return QQmlListProperty<GroupProducts>(this, nullptr, &QMLdata::count_group, &QMLdata::at_group);
}

int QMLdata::count_group(QQmlListProperty<GroupProducts> *list)
{
    QMLdata *msgBoard = qobject_cast<QMLdata *>(list->object);
    return msgBoard->groupProducts.size();
}

GroupProducts* QMLdata::at_group(QQmlListProperty<GroupProducts> *list, int index)
{
    QMLdata *msgBoard = qobject_cast<QMLdata *>(list->object);
    return msgBoard->groupProducts[index];
}

void QMLdata::makeGroups(QVector<Product *> *products)
{
    groupProducts.clear();
    for(QVector<Product *>::Iterator it =products->begin(); it != products->end(); it++)
    {
        Product * product = *it;
            auto itr = std::find_if(groupProducts.begin()
                                    , groupProducts.end()
                                    , [product](GroupProducts* var)
                                    { return var->getCategory() == product->getCat(); }
                                    );
            if(itr != groupProducts.end())
            {
                (*itr)->addProduct(product);
            }
            else
            {
                GroupProducts * group = new GroupProducts(product->getCat());
                group->addProduct(product);
                groupProducts.append(group);
            }

    }
    emit groupProductsChanged();
}

#include "groupproducts.h"
#include "datatransfer.h"

GroupProducts::GroupProducts(Product::Category cat, QObject *parent)
    : QObject(parent), category(cat)

{

}

GroupProducts::GroupProducts(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<Product> GroupProducts::Products()
{
    return QQmlListProperty<Product>(this, nullptr, &GroupProducts::count_products, &GroupProducts::at_group);
}

int GroupProducts::count_products(QQmlListProperty<Product> *list)
{
    GroupProducts *msgBoard = qobject_cast<GroupProducts *>(list->object);
    return msgBoard->products.size();
}

Product* GroupProducts::at_group(QQmlListProperty<Product> *list, int index)
{
    GroupProducts *msgBoard = qobject_cast<GroupProducts *>(list->object);
    return msgBoard->products[index];
}

void GroupProducts::addProduct(Product * product)
{
    products.append(product);
}

QList<Product *> GroupProducts::getProducts()  {
    return products;
}

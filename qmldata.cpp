#include "qmldata.h"
#include "product.h"

QMLdata::QMLdata(QObject *parent) : QObject(parent)
{
}

QMLdata::QMLdata(QVector<Product *> *products, QObject *parent) : QObject(parent)
{
    makeGroups(products);
}

QQmlListProperty<ProductsTableModel> QMLdata::getTableModels()
{
    return QQmlListProperty<ProductsTableModel>(this, nullptr, &QMLdata::count_group, &QMLdata::at_group);
}

int QMLdata::count_group(QQmlListProperty<ProductsTableModel> *list)
{
    QMLdata *msgBoard = qobject_cast<QMLdata *>(list->object);
    return msgBoard->groupModels.size();
}

ProductsTableModel* QMLdata::at_group(QQmlListProperty<ProductsTableModel> *list, int index)
{
    QMLdata *msgBoard = qobject_cast<QMLdata *>(list->object);
    return msgBoard->groupModels[index];
}

void QMLdata::makeGroups(QVector<Product *> *products)
{
    groupModels.clear();
    categories = 0;
    for(QVector<Product *>::Iterator it =products->begin(); it != products->end(); it++)
    {
        Product * product = *it;
            auto itr = std::find_if(groupModels.begin()
                                    , groupModels.end()
                                    , [product](ProductsTableModel* var)
                                    { return var->getCategory() == product->getCat(); }
                                    );
            if(itr != groupModels.end())
            {
                (*itr)->addProduct(product->getFullName(), product->getTerm());
            }
            else
            {
                ProductsTableModel * model = new ProductsTableModel();
                model->addProduct(product->getFullName(), product->getTerm());
                model->setCategory(product->getCat());
                groupModels.append(model);
                categories++;
            }

    }
    emit groupProductsChanged();
}

int QMLdata::amountCategories()
{
    return categories;
}

//void QMLdata::test() {
//    QVector<Product *> a;
//    a.append(new Product("HEHEHEH", QDate::fromString("22.11.2011", "dd.MM.yyyy"), Product::Fishes));
//    a.append(new Product("FFFF", QDate::fromString("22.11.2011", "dd.MM.yyyy"), Product::Fishes));
//    a.append(new Product("HEHEHEH", QDate::fromString("22.11.2011", "dd.MM.yyyy"), Product::Dairy));
//    makeGroups(&a);
//}

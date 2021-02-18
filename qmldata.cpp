#include "qmldata.h"
#include "product.h"
#include "datatransfer.h"

QMLdata::QMLdata(QObject *parent) : QObject(parent)
{
    alertRange = 7;
}

QMLdata::QMLdata(DataTransfer *data, QObject *parent) : QObject(parent)
{
    this->shoplist = data->getShopList();
    this->data = data;
    alertRange = 7;
    QObject::connect(data, SIGNAL(dataReceived(QVector<Product *> *)), this, SLOT(makeGroups(QVector<Product *> *)));
    makeGroups(data->getProducts());
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
    ProductsTableModel * endOfExpiryDateModel  = new ProductsTableModel();
    endOfExpiryDateModel->setCategory(Product::EndOfExpiry);
    QDate shiftedDate = QDate::currentDate().addDays(alertRange);
    groupModels.clear();
    categories = 0;
    auto foundEndofExpiry = false;
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

        if(QDate(product->getDate()) <= shiftedDate)
        {
            qDebug() << QDate(product->getDate()).toString() << " " << shiftedDate.toString();
            endOfExpiryDateModel->addProduct(product->getFullName(), product->getTerm());
            foundEndofExpiry = true;
        }
    }
    if(foundEndofExpiry)
    {
        groupModels.append(endOfExpiryDateModel);
        categories++;
    }

    emit groupProductsChanged();
    emit amountCategoriesChanged();
    emit shoplistChanged();
    emit shoplistSizeChanged();
}

int QMLdata::amountCategories()
{
    return categories;
}

QStringList QMLdata::getShopList()
{
    return *shoplist;
}

int QMLdata::getShopListSize()
{
    return shoplist->size();
}

void QMLdata::refreshData()
{
    data->refreshData();
}
//void QMLdata::test() {
//    QVector<Product *> a;
//    a.append(new Product("HEHEHEH", QDate::fromString("22.11.2011", "dd.MM.yyyy"), Product::Fishes));
//    a.append(new Product("FFFF", QDate::fromString("22.11.2011", "dd.MM.yyyy"), Product::Fishes));
//    a.append(new Product("HEHEHEH", QDate::fromString("22.11.2011", "dd.MM.yyyy"), Product::Dairy));
//    makeGroups(&a);
//}

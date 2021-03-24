#include "qmldata.h"
#include "product.h"
#include "datatransfer.h"
#include <QStandardPaths>
#include "QtNotification.h"

QMLdata::QMLdata(QObject *parent) : QObject(parent)
{
    alertRange = 7;
}

QMLdata::QMLdata(DataTransfer *data, QObject *parent) : QObject(parent)
{
    QFile file(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + ".ini");
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray arr;
        QTextStream stream(&file);
        stream >> arr;
        file.close();
        QString readData(arr);
        QStringList splited = readData.split("=");
        auto readVar = splited[1].toInt();
        if(readVar <= 15 and readVar >= 0)
            alertRange = readVar;
        else
            alertRange = 7;
    }else{
        alertRange = 7;
    }
    this->shoplist = data->getShopList();
    this->data = data;
    endOfExpiryDateModel  = QSharedPointer<ProductsTableModel>(new ProductsTableModel());
    endOfExpiryDateModel->setCategory(Product::EndOfExpiry);
    QObject::connect(data, SIGNAL(dataReceived(QVector<QSharedPointer<Product>> *, QString)), this, SLOT(makeGroups(QVector<QSharedPointer<Product>> *, QString)));
    QObject::connect(data, SIGNAL(shopListChanged()), this, SLOT(changeShopList()));
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
    return msgBoard->groupModels[index].get();
}

void QMLdata::changeShopList()
{
    this->shoplist = data->getShopList();
    emit shoplistChanged();
    emit shoplistSizeChanged();

    QString str("Shopping list has been changed, check it!");
    showNotify(str);
}

void QMLdata::makeGroups(QVector<QSharedPointer<Product>> *products, QString creatingDate)
{
    QDateTime date = QDateTime::currentDateTime();
    auto date_format = date.toString("dd.MM.yyyy hh:mm");
    this->refreshDate = date_format;
    if(products == nullptr)
    {
        emit refreshDateChanged();
        return;
    }
    this->creatingDate = creatingDate;
    QDate currentDate = QDate::currentDate();
    QDate shiftedDate = currentDate.addDays(alertRange);
    groupModels.clear();
    endOfExpiryDateModel->clear();
    auto foundEndofExpiry = false;
    for(QVector<QSharedPointer<Product>>::Iterator it =products->begin(); it != products->end(); it++)
    {
        QSharedPointer<Product> product = *it;
        auto itr = std::find_if(groupModels.begin()
                                , groupModels.end()
                                , [product](QSharedPointer<ProductsTableModel> var)
        { return var->getCategory() == product->getCat(); }
                );

        if(QDate(product->getDate()) < currentDate)
        {
            product->setRedTerm(true);
            endOfExpiryDateModel->addProduct(product->getFullName(), product->getDate(), product->getRedTerm(), product->getYellowTerm());
            foundEndofExpiry = true;
        }
        else if(QDate(product->getDate()) <= shiftedDate)
        {
            product->setYellowTerm(true);
            endOfExpiryDateModel->addProduct(product->getFullName(), product->getDate(), product->getRedTerm(), product->getYellowTerm());
            foundEndofExpiry = true;
        }

        if(itr != groupModels.end())
        {
            (*itr)->addProduct(product->getFullName(), product->getDate(), product->getRedTerm(), product->getYellowTerm());
        }
        else
        {
            QSharedPointer<ProductsTableModel> model =
                    QSharedPointer<ProductsTableModel>(new ProductsTableModel(), &QObject::deleteLater);
            model->addProduct(product->getFullName(), product->getDate(), product->getRedTerm(), product->getYellowTerm());
            model->setCategory(product->getCat());
            groupModels.append(model);
        }
    }
    if(foundEndofExpiry)
    {
        groupModels.append(endOfExpiryDateModel);
    }
    for(auto var : groupModels){
        var->sortModel();
    }

    emit amountCategoriesChanged();
    emit groupProductsChanged();
    emit creatingDateChanged();
    emit refreshDateChanged();
}

int QMLdata::getAmountCategories()
{
    return groupModels.count();
}

QStringList QMLdata::getShopList()
{
    return shoplist;
}

int QMLdata::getShopListSize()
{
    return shoplist.size();
}

void QMLdata::refreshData()
{
    data->refreshData();
}

void QMLdata::refreshEndExpiryModel()
{
    endOfExpiryDateModel->clear();
    QVector<QSharedPointer<Product>> *products = data->getProducts();
    QDate currentDate = QDate::currentDate();
    QDate shiftedDate = currentDate.addDays(alertRange);
    auto foundEndofExpiry = false;

    for(QVector<QSharedPointer<Product>>::Iterator it =products->begin(); it != products->end(); it++)
    {
        QSharedPointer<Product> product = *it;
        product->setYellowTerm(false);
        product->setRedTerm(false);

        if(QDate(product->getDate()) < currentDate)
        {
            product->setRedTerm(true);
            endOfExpiryDateModel->addProduct(product->getFullName(), product->getDate(), product->getRedTerm(), product->getYellowTerm());
            foundEndofExpiry = true;
        }
        else if(QDate(product->getDate()) <= shiftedDate)
        {
            product->setYellowTerm(true);
            endOfExpiryDateModel->addProduct(product->getFullName(), product->getDate(), product->getRedTerm(), product->getYellowTerm());
            foundEndofExpiry = true;
        }
    }
    if(!foundEndofExpiry and groupModels.contains(endOfExpiryDateModel))
    {
        groupModels.removeLast();
    }
    else if(!groupModels.contains(endOfExpiryDateModel) and foundEndofExpiry)
    {
        endOfExpiryDateModel->sortModel();
        groupModels.append(endOfExpiryDateModel);
    }

    emit amountCategoriesChanged();
    emit groupProductsChanged();

}

void QMLdata::setAlertRange(int range)
{
    alertRange = range;
    emit alertRangeChanged();
}

void QMLdata::showNotify(QString title)
{
    QtNotification notify;
    QMap<QString, QVariant> map;

    map.insert("caption", QVariant(title));
    map.insert("title", QVariant("Smart Fridge"));
    map.insert("id", QVariant(0));
    notify.show(map);
}
void QMLdata::saveConfig(Qt::ApplicationState state)
{
    if (state != Qt::ApplicationActive)
    {
        QFile file(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + ".ini");
        if(file.open(QIODevice::WriteOnly))
        {
            QString alertAlias = "AlertRange=";
            QByteArray arr = alertAlias.toLocal8Bit();
            arr.append(QByteArray::number(alertRange,10));
            QTextStream stream(&file);
            stream << arr;
            file.close();
        }
    }
}

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
    endOfExpiryDateModel  = new ProductsTableModel();
    endOfExpiryDateModel->setCategory(Product::EndOfExpiry);
    QObject::connect(data, SIGNAL(dataReceived(QVector<Product *> *, QString)), this, SLOT(makeGroups(QVector<Product *> *, QString)));
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

void QMLdata::makeGroups(QVector<Product *> *products, QString creatingDate)
{
    this->creatingDate = creatingDate;
    QDate currentDate = QDate::currentDate();
    QDateTime date = QDateTime::currentDateTime();
    auto a = date.toString("dd.MM.yyyy hh:mm");
    this->refreshDate = a;
    QDate shiftedDate = currentDate.addDays(alertRange);
    groupModels.clear();
    endOfExpiryDateModel->clear();
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
            ProductsTableModel * model = new ProductsTableModel();
            model->addProduct(product->getFullName(), product->getDate(), product->getRedTerm(), product->getYellowTerm());
            model->setCategory(product->getCat());
            groupModels.append(model);
            categories++;
        }
    }
    if(foundEndofExpiry)
    {
        groupModels.append(endOfExpiryDateModel);
        categories++;
    }
    for(auto var : groupModels){
        var->sortModel();
    }

    if(endOfExpiryDateModel->rowCount() > 0)
    {
        QtNotification notify;
        QMap<QString, QVariant> map;
        QString var(QString::number(endOfExpiryDateModel->rowCount()));
        QString str("Ending products: " + var + ", check it!");
        map.insert("caption", QVariant(str));
        map.insert("title", QVariant("Expiriation"));
        map.insert("id", QVariant(0));
        notify.show(map);
    }

    emit groupProductsChanged();
    emit amountCategoriesChanged();
    emit shoplistChanged();
    emit shoplistSizeChanged();
    emit creatingDateChanged();
    emit refreshDateChanged();
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

void QMLdata::refreshEndExpiryModel()
{
    endOfExpiryDateModel->clear();
    QVector<Product *> *products = data->getProducts();
    QDate currentDate = QDate::currentDate();
    QDate shiftedDate = currentDate.addDays(alertRange);
    auto foundEndofExpiry = false;

    for(QVector<Product *>::Iterator it =products->begin(); it != products->end(); it++)
    {
        Product * product = *it;
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
        categories--;
    }
    else if(!groupModels.contains(endOfExpiryDateModel))
    {
        endOfExpiryDateModel->sortModel();
        groupModels.append(endOfExpiryDateModel);
        categories++;
    }

    emit groupProductsChanged();
    emit amountCategoriesChanged();
}

void QMLdata::setAlertRange(int range)
{
    alertRange = range;
    emit alertRangeChanged();
}

QMLdata::~QMLdata()
{
    delete endOfExpiryDateModel;

}

void QMLdata::fun(Qt::ApplicationState state)
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

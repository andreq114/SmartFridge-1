#ifndef QMLDATA_H
#define QMLDATA_H

#include <QObject>
#include "groupproducts.h"
#include "productstablemodel.h"
#include <QQmlListProperty>

class QMLdata : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ProductsTableModel> groupModels READ getTableModels NOTIFY groupProductsChanged)
    Q_PROPERTY(int amountCategories READ amountCategories NOTIFY amountCategoriesChanged)
    Q_PROPERTY(QStringList shoplist READ getShopList NOTIFY shoplistChanged)
public:
    explicit QMLdata(QObject *parent = nullptr);
    explicit QMLdata(DataTransfer *data,  QObject *parent = nullptr);
    QList<ProductsTableModel *> groupModels;
    QStringList * shoplist;

    QQmlListProperty<ProductsTableModel> getTableModels();
    QStringList getShopList();
    int getShopListSize();
    int amountCategories();

    Q_INVOKABLE void refreshData();

    //Q_INVOKABLE void test();

    static int count_group(QQmlListProperty<ProductsTableModel> *list);
    static ProductsTableModel* at_group(QQmlListProperty<ProductsTableModel> *list, int index);

signals:
    void groupProductsChanged();
    void amountCategoriesChanged();
    void shoplistChanged();
    void shoplistSizeChanged();

public slots:
    void makeGroups(QVector<Product *> *products);

private:
    int categories;
    DataTransfer *data;
};

#endif // QMLDATA_H

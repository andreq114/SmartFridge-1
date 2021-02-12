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
    explicit QMLdata(QVector<Product *> *products, QStringList * shoplist,  QObject *parent = nullptr);
    QList<ProductsTableModel *> groupModels;
    QStringList * shoplist;

    QQmlListProperty<ProductsTableModel> getTableModels();
    QStringList getShopList();
    int getShopListSize();
    int amountCategories();

    //Q_INVOKABLE void test();

    static int count_group(QQmlListProperty<ProductsTableModel> *list);
    static ProductsTableModel* at_group(QQmlListProperty<ProductsTableModel> *list, int index);

signals:
    void groupProductsChanged();
    void amountCategoriesChanged();
    void shoplistChanged();
    void shoplistSizeChanged();

public slots:
    void shopListSignal(QVector<Product *> *products){makeGroups(products);}

private:
    void makeGroups(QVector<Product *> *products);
    int categories;
};

#endif // QMLDATA_H

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
public:
    explicit QMLdata(QObject *parent = nullptr);
    explicit QMLdata(QVector<Product *> *products, QObject *parent = nullptr);
    QList<ProductsTableModel *> groupModels;

    QQmlListProperty<ProductsTableModel> getTableModels();
    int amountCategories();
    Q_INVOKABLE void test();

    static int count_group(QQmlListProperty<ProductsTableModel> *list);
    static ProductsTableModel* at_group(QQmlListProperty<ProductsTableModel> *list, int index);
signals:
    void groupProductsChanged();
    void amountCategoriesChanged();

private:
    void makeGroups(QVector<Product *> *products);
    int categories;
};

#endif // QMLDATA_H

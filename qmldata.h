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
    Q_PROPERTY(int alertRange READ getAlertRange WRITE setAlertRange NOTIFY alertRangeChanged)
    Q_PROPERTY(QString creatingDate READ getCreatingDate NOTIFY creatingDateChanged)
public:
    explicit QMLdata(QObject *parent = nullptr);
    explicit QMLdata(DataTransfer *data,  QObject *parent = nullptr);
    ~QMLdata() override;
    QList<ProductsTableModel *>             groupModels;
    QStringList * shoplist;

    QQmlListProperty<ProductsTableModel>    getTableModels();
    QStringList                             getShopList();
    int                                     getShopListSize();
    int                                     amountCategories();
    int                                     getAlertRange() { return alertRange;}
    void                                    setAlertRange(int range);
    QString                                 getCreatingDate() { return creatingDate;}

    Q_INVOKABLE void                        refreshData();
    Q_INVOKABLE void                        refreshEndExpiryModel();

    static int                              count_group(QQmlListProperty<ProductsTableModel> *list);
    static ProductsTableModel*              at_group(QQmlListProperty<ProductsTableModel> *list, int index);

signals:
    void                                    groupProductsChanged();
    void                                    amountCategoriesChanged();
    void                                    shoplistChanged();
    void                                    shoplistSizeChanged();
    void                                    alertRangeChanged();
    void                                    creatingDateChanged();

public slots:
    void                                    makeGroups(QVector<Product *> *products, QString creatingDate);
    void                                    fun(Qt::ApplicationState);

private:
    int                 categories;
    DataTransfer*       data;
    int                 alertRange;
    QString             creatingDate;
    ProductsTableModel* endOfExpiryDateModel;
};

#endif // QMLDATA_H

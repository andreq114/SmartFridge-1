#ifndef MANAGERQML_H
#define MANAGERQML_H

#include <QObject>
#include "ThinkspeakNetManager.h"
#include "ProductsTableModel.h"
#include <QQmlListProperty>

class ManagerQML : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ProductsTableModel> groupModels READ getTableModels NOTIFY groupProductsChanged)
    Q_PROPERTY(int amountCategories READ getAmountCategories NOTIFY amountCategoriesChanged)
    Q_PROPERTY(QStringList shoppinglist READ getShopList NOTIFY shoplistChanged)
    Q_PROPERTY(int alertRange READ getAlertRange WRITE setAlertRange NOTIFY alertRangeChanged)
    Q_PROPERTY(QString creatingDate READ getCreatingDate NOTIFY creatingDateChanged)

public:
    explicit ManagerQML(QObject *parent = nullptr);
    explicit ManagerQML(ThingspeakNetManager *data,  QObject *parent = nullptr);

    QQmlListProperty<ProductsTableModel>    getTableModels();
    QStringList                             getShopList();
    int                                     getAmountCategories();
    int                                     getAlertRange() { return alertRange;}
    void                                    setAlertRange(int range);
    QString                                 getCreatingDate() { return creatingDate;}

    Q_INVOKABLE void                        refreshData();
    Q_INVOKABLE void                        refreshEndExpiryModel();
    Q_INVOKABLE void                        clearNotify();

    static int                              count_group(QQmlListProperty<ProductsTableModel> *list);
    static ProductsTableModel*              at_group(QQmlListProperty<ProductsTableModel> *list, int index);

public slots:
    void                                    saveConfig(Qt::ApplicationState);

signals:
    void                                    amountCategoriesChanged();
    void                                    groupProductsChanged();
    void                                    shoplistChanged();
    void                                    shoplistSizeChanged();
    void                                    alertRangeChanged();
    void                                    creatingDateChanged();

private slots:
    void                                    makeGroups(QVector<QSharedPointer<Product>> *products, QString creatingDate);
    void                                    changeShopList();

private:
    ThingspeakNetManager*                   data;
    int32_t                                 alertRange;
    QString                                 creatingDate;
    QSharedPointer<ProductsTableModel>      endOfExpiryDateModel;
    QList<QSharedPointer<ProductsTableModel>>groupModels;
    QStringList                             shoppinglist;

    void                                    showNotify(QString title);
};

#endif // MANAGERQML_H

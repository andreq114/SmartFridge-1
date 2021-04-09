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
    Q_PROPERTY(QStringList shoplist READ getShopList NOTIFY shoplistChanged)
    Q_PROPERTY(int alertRange READ getAlertRange WRITE setAlertRange NOTIFY alertRangeChanged)
    Q_PROPERTY(QString creatingDate READ getCreatingDate NOTIFY creatingDateChanged)

public:
    explicit ManagerQML(QObject *parent = nullptr);
    explicit ManagerQML(ThingspeakNetManager *data,  QObject *parent = nullptr);

    QList<QSharedPointer<ProductsTableModel>>groupModels;
    QStringList shoplist;

    QQmlListProperty<ProductsTableModel>    getTableModels();
    QStringList                             getShopList();
    int                                     getShopListSize();
    int                                     getAmountCategories();
    int                                     getAlertRange() { return alertRange;}
    void                                    setAlertRange(int range);
    QString                                 getCreatingDate() { return creatingDate;}
    QString                                 getRefreshDate() { return refreshDate;}

    Q_INVOKABLE void                        refreshData();
    Q_INVOKABLE void                        refreshEndExpiryModel();
    Q_INVOKABLE void                        refresh();
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
    void                                    refreshDateChanged();

private slots:
    void                                    makeGroups(QVector<QSharedPointer<Product>> *products, QString creatingDate);
    void                                    changeShopList();

private:
    ThingspeakNetManager*                           data;
    int32_t                                 alertRange;
    QString                                 creatingDate;
    QString                                 refreshDate;
    QSharedPointer<ProductsTableModel>      endOfExpiryDateModel;

    void                                    showNotify(QString title);
};

#endif // MANAGERQML_H

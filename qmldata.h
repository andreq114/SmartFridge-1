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
    Q_PROPERTY(int amountCategories READ getAmountCategories NOTIFY amountCategoriesChanged)
    Q_PROPERTY(QStringList shoplist READ getShopList NOTIFY shoplistChanged)
    Q_PROPERTY(int alertRange READ getAlertRange WRITE setAlertRange NOTIFY alertRangeChanged)
    Q_PROPERTY(QString creatingDate READ getCreatingDate NOTIFY creatingDateChanged)
    Q_PROPERTY(QString refreshDate READ getRefreshDate NOTIFY refreshDateChanged)

public:
    explicit QMLdata(QObject *parent = nullptr);
    explicit QMLdata(DataTransfer *data,  QObject *parent = nullptr);

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

    static int                              count_group(QQmlListProperty<ProductsTableModel> *list);
    static ProductsTableModel*              at_group(QQmlListProperty<ProductsTableModel> *list, int index);

public slots:
    void                                    saveConfig(Qt::ApplicationState);

signals:
    void                                    groupProductsChanged();
    void                                    amountCategoriesChanged();
    void                                    shoplistChanged();
    void                                    shoplistSizeChanged();
    void                                    alertRangeChanged();
    void                                    creatingDateChanged();
    void                                    refreshDateChanged();

private slots:
    void                                    makeGroups(QVector<QSharedPointer<Product>> *products, QString creatingDate);
    void                                    changeShopList();

private:
    DataTransfer*                           data;
    int32_t                                 alertRange;
    QString                                 creatingDate;
    QString                                 refreshDate;
    QSharedPointer<ProductsTableModel>      endOfExpiryDateModel;

    void                                    showNotify(QString title);
};

#endif // QMLDATA_H

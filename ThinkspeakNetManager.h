#ifndef THINKSPEAKNETMANAGER_H
#define THINKSPEAKNETMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QNetworkReply>
#include <QThread>
#include <QTimer>
#include "Product.h"

class ThingspeakNetManager : public QObject
{
    Q_OBJECT
public:
    ThingspeakNetManager();
    ~ThingspeakNetManager() override;

    QVector<QSharedPointer<Product>>*getProducts();
    QStringList                     getShopList();
public slots:
    void                            refreshData();
signals:
    void dataReceived(QVector<QSharedPointer<Product>> *, QString );
    void shopListChanged();
private:
    QNetworkRequest                 request;
    QNetworkReply                   *reply = nullptr;
    QNetworkAccessManager           *restclient = nullptr;
    QVector<QSharedPointer<Product>> products;
    QStringList                     shoplist;
    QString                         creatingDate;
    QString                         lastCreatingDate;
    QThread                         *requestThread = nullptr;
    QTimer                          *timer = nullptr;

    void parseReply(QVector<QString> &fields);
    void clearRefProd();

private slots:
    void replyFinished(QNetworkReply * reply);
    void run();
};


#endif // THINKSPEAKNETMANAGER_H

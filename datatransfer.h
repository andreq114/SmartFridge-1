#ifndef DATATRANSFER_H
#define DATATRANSFER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QNetworkReply>
#include "product.h"

class DataTransfer : public QObject
{
    Q_OBJECT
public:
    DataTransfer();

    QVector<QSharedPointer<Product>>*getProducts();
    QStringList                     *getShopList();
    void                            refreshData();
signals:
    void dataReceived(QVector<QSharedPointer<Product>> *, QString );
private:
    QNetworkRequest                 request;
    QNetworkReply                   *reply;
    QNetworkAccessManager           *restclient;
    QVector<QSharedPointer<Product>> products;
    QStringList                     shoplist;
    QString                         creatingDate;

    void parseReply(QVector<QString> &fields);
    void clearRefProd();
private slots:
    void replyFinished(QNetworkReply * reply);
};


#endif // DATATRANSFER_H

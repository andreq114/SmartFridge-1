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

    QVector<Product *>              *getProducts();
    QStringList                     *getShopList();
signals:
    void dataReceived(QVector<Product *> *);
private:
    QNetworkRequest                 request;
    QNetworkReply                   *reply;
    QNetworkAccessManager           *restclient;
    QVector<Product *>              products;
    QStringList                     shoplist;

    void parseReply(QString &field1, QString &field2, QString &field3, QString &field4, QString &field5, QString &field6, QString &field7);
private slots:
    void replyFinished(QNetworkReply * reply);
};


#endif // DATATRANSFER_H

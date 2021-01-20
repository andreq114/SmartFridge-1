#ifndef DATATRANSFER_H
#define DATATRANSFER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QNetworkReply>

struct Product;

enum Category{
    Dairy,
    Drinks,
    Alcohols,
    Sauces,
    Sweets,
    Fishes,
    Meat,
    Frozen,
    Plants
};

class DataTransfer : public QObject
{
    Q_OBJECT
public:
    DataTransfer();
private:
    QUrl myurl;
    QNetworkRequest request;
    QNetworkReply *reply;
    QNetworkAccessManager *restclient;
    QVector<Product> products;

    QVector<Product> parseReply(QString &field2, QString &field3, QString &field4);
private slots:
    void replyFinished(QNetworkReply * reply);
};

struct Product{
    QString name;
    QDate term;
    Category category;
};



#endif // DATATRANSFER_H

#include "datatransfer.h"

DataTransfer::DataTransfer()
{
    restclient = new QNetworkAccessManager();
    QUrl myurl;
    myurl.setScheme("http");
    myurl.setHost("api.thingspeak.com");
    myurl.setPath("/channels/1242116/feed.json");

    request.setUrl(myurl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    connect(restclient, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply *)));

    //reply = restclient->get(request);
    QString field1 ("Chocolate$Mineral water$"),
            field2 ("Wedel$Oaza$"),
            field3 ("Strawberry$$"),
            field4 ("100 g$1.5l$"),
            field5 ("05.09.2021$22.12.2022$"),
            field6 ("4$4$"),
            field7 ("Masło Margaryna 400g$Kurczak pierś filet 300g$Śmietana wyborowa 2l$");
    parseReply(field1, field2, field3, field4, field5, field6, field7);
}

void DataTransfer::replyFinished(QNetworkReply * reply){

    QJsonDocument jsdoc;
    QJsonArray jsarr;
    QString field2, field3, field4, field1, field5, field6, field7;
    jsdoc = QJsonDocument::fromJson(reply->readAll());
    QJsonObject jsobj = jsdoc.object();
    jsarr = jsobj["feeds"].toArray();
    foreach (const QJsonValue &value, jsarr) {
        QJsonObject jsob = value.toObject();
        field1 = jsob["field1"].toString();
        field2 = jsob["field2"].toString();
        field3 = jsob["field3"].toString();
        field4 = jsob["field4"].toString();
        field5 = jsob["field5"].toString();
        field6 = jsob["field6"].toString();
        field7 = jsob["field7"].toString();
    }
    reply->deleteLater();
    parseReply(field1, field2, field3, field4, field5, field6, field7);

    emit dataReceived(&products);
}

void DataTransfer::parseReply(QString &field1, QString &field2, QString &field3, QString &field4, QString &field5, QString &field6, QString &field7)
{
    auto names = field1.split("$");
    auto company = field2.split("$");
    auto desc = field3.split("$");
    auto mass = field4.split("$");
    auto terms = field5.split("$");
    auto category = field6.split("$");
    auto shoplist = field7.split("$");

    names.removeAt(names.length() - 1);
    company.removeAt(company.length() - 1);
    desc.removeAt(desc.length() - 1);
    mass.removeAt(mass.length() - 1);
    terms.removeAt(terms.length() - 1);
    category.removeAt(category.length() - 1);
    shoplist.removeAt(shoplist.length() - 1);

    products.clear();
    products.resize(names.size());

    for(int i = 0; i < names.size(); i++)
    {
        products[i] = new Product(names.at(i),
                                  company.at(i),
                                  desc.at(i),
                                  mass.at(i),
                                  QDate::fromString(terms.at(i), "dd.MM.yyyy"),
                                  static_cast<Product::Category>(category.at(i).toInt()),
                                  nullptr);
    }

    for(int i = 0; i < shoplist.size(); i++)
    {
        this->shoplist.append(*new QString(shoplist.at(i)));
    }
}


QVector<Product *> * DataTransfer::getProducts(){
    return &products;
}

QStringList * DataTransfer::getShopList(){
    return &shoplist;
}

void  DataTransfer::refreshData()
{
    //reply = restclient->get(request);
    QString field1 ("huj$pedal$"),
            field2 ("Wedel$Oaza$"),
            field3 ("Strawberry$$"),
            field4 ("100 g$1.5l$"),
            field5 ("05.09.2021$22.12.2022$"),
            field6 ("4$3$"),
            field7 ("Masło Margaryna 400g$Kurczak pierś filet 300g$Śmietana wyborowa 2l$");
    parseReply(field1, field2, field3, field4, field5, field6, field7);
    emit dataReceived(&products);
}

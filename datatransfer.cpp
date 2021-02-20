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

    reply = restclient->get(request);
//    QString field1 ("Chocolate$Mineral water$Chocolate$Chocolate$"),
//            field2 ("Wedel$Oaza$Wedel$Wedel$"),
//            field3 ("Strawberry$$Strawberry$Strawberry$"),
//            field4 ("100 g$1.5l$100 g$100 g$"),
//            field5 ("20.02.2021$27.02.2021$05.03.2021$22.02.2021$"),
//            field6 ("4$4$4$4$"),
//            field7 ("Masło Margaryna 400g$Kurczak pierś filet 300g$Śmietana wyborowa 2l$");
//    parseReply(field1, field2, field3, field4, field5, field6, field7);
}

void DataTransfer::replyFinished(QNetworkReply * reply){

    QJsonDocument jsdoc;
    QJsonArray jsarr;
    QVector<QString> fields(8);
    jsdoc = QJsonDocument::fromJson(reply->readAll());
    QJsonObject jsobj = jsdoc.object();
    jsarr = jsobj["feeds"].toArray();
    foreach (const QJsonValue &value, jsarr) {
        QJsonObject jsob = value.toObject();
        fields[0] = jsob["field1"].toString();
        fields[1] = jsob["field2"].toString();
        fields[2] = jsob["field3"].toString();
        fields[3] = jsob["field4"].toString();
        fields[4] = jsob["field5"].toString();
        fields[5] = jsob["field6"].toString();
        fields[6] = jsob["field7"].toString();
        fields[7] = jsob["created_at"].toString();
    }
    reply->deleteLater();
    parseReply(fields);

    emit dataReceived(&products, creatingDate);
}

void DataTransfer::parseReply(QVector<QString> &fields)
{
    auto names = fields[0].split("$");
    auto company = fields[1].split("$");
    auto desc = fields[2].split("$");
    auto mass = fields[3].split("$");
    auto terms = fields[4].split("$");
    auto category = fields[5].split("$");
    auto shoplist = fields[6].split("$");
    creatingDate = fields[7];

    names.removeAt(names.length() - 1);
    company.removeAt(company.length() - 1);
    desc.removeAt(desc.length() - 1);
    mass.removeAt(mass.length() - 1);
    terms.removeAt(terms.length() - 1);
    category.removeAt(category.length() - 1);
    shoplist.removeAt(shoplist.length() - 1);


    products.clear();
    products.resize(names.size());
    this->shoplist.clear();

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
    reply = restclient->get(request);
//    QString field1 ("Cukierasy$Pepsi$"),
//            field2 ("Wedel$Kola$"),
//            field3 ("Rozne$$"),
//            field4 ("100 g$1.5l$"),
//            field5 ("05.02.2021$22.12.2022$"),
//            field6 ("4$3$"),
//            field7 ("Masło Margaryna 400g$Kurczak pierś filet 300g$Śmietana wyborowa 2l$");
//    parseReply(field1, field2, field3, field4, field5, field6, field7);
//    emit dataReceived(&products);
}

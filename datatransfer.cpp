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
    QString field2 ("Smietana niebita$Keczup$Ogórki kiszione$Hehe- piotr zyla$"),
            field3 ("21.11.2022$02.05.2021$02.05.2021$11.11.2023$"),
            field4 ("0$3$6$4$");
    parseReply(field2, field3, field4);
}

void DataTransfer::replyFinished(QNetworkReply * reply){

    QJsonDocument jsdoc;
    QJsonArray jsarr;
    QString field2, field3, field4;
    jsdoc = QJsonDocument::fromJson(reply->readAll());
    QJsonObject jsobj = jsdoc.object();
    jsarr = jsobj["feeds"].toArray();
    foreach (const QJsonValue &value, jsarr) {
        QJsonObject jsob = value.toObject();
        field2 = jsob["field2"].toString();
        field3 = jsob["field3"].toString();
        field4 = jsob["field4"].toString();
    }
    reply->deleteLater();
    parseReply(field2, field3, field4);

}

void DataTransfer::parseReply(QString &field2, QString &field3, QString &field4){

    auto names = field2.split("$");
    auto terms = field3.split("$");
    auto category = field4.split("$");

    names.removeAt(names.length() - 1);
    terms.removeAt(terms.length() - 1);
    category.removeAt(category.length() - 1);

    products.clear();
    products.resize(names.size());

    for(int i = 0; i < names.size(); i++)
    {
        products[i] = new Product(names.at(i)
                                    , QDate::fromString(terms.at(i), "dd.MM.yyyy")
                                    , static_cast<Product::Category>(category.at(i).toInt())
                                    , nullptr);
    }

}


QVector<Product *> * DataTransfer::getProducts(){
    return &products;
}










#include "ThinkspeakNetManager.h"

ThingspeakNetManager::ThingspeakNetManager()
{
    restclient          = new QNetworkAccessManager();
    requestThread       = new QThread();
    timer               = new QTimer();
    moveToThread(requestThread);

    QUrl myurl;
    myurl.setScheme("http");
    myurl.setHost("api.thingspeak.com");
    myurl.setPath("/channels/1242116/feed.json");

    request.setUrl(myurl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    connect(requestThread, SIGNAL(started()), this, SLOT(run()));
    connect(restclient, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply *)));
    connect(timer, SIGNAL(timeout()), this, SLOT(refreshData()), Qt::QueuedConnection);

    timer->moveToThread(requestThread);
    requestThread->start();
}

ThingspeakNetManager::~ThingspeakNetManager()
{
    if(restclient)
        delete restclient;
    if(requestThread)
        delete requestThread;
    if(timer)
        delete timer;
}

void ThingspeakNetManager::run()
{
    this->refreshData();
    timer->start(20000);    // 20sek
}

void ThingspeakNetManager::replyFinished(QNetworkReply * reply){

    if(reply->error() != QNetworkReply::NoError)
    {
        return;
    }
    QJsonDocument jsdoc;
    QJsonArray jsarr;
    QVector<QString> fields(7);
    QString thingspeakUpdateDate;
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
        fields[6] = jsob["field7"].toString() + jsob["field8"].toString();
        thingspeakUpdateDate = jsob["created_at"].toString();
    }
    reply->deleteLater();

    if(thingspeakUpdateDate == creatingDate)
    {
        emit dataReceived(nullptr, nullptr);
        return;
    }
    else
        creatingDate = thingspeakUpdateDate;

    parseReply(fields);

    emit dataReceived(&products, creatingDate);
}

void ThingspeakNetManager::parseReply(QVector<QString> &fields)
{
    auto names = fields[0].split("$");
    auto company = fields[1].split("$");
    auto desc = fields[2].split("$");
    auto mass = fields[3].split("$");
    auto terms = fields[4].split("$");
    auto category = fields[5].split("$");
    auto shoplist = fields[6].split("$");

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
        products[i] =  QSharedPointer<Product>(new Product(names.at(i),
                                                            company.at(i),
                                                            desc.at(i),
                                                            mass.at(i),
                                                            QDate::fromString(terms.at(i), "dd.MM.yyyy"),
                                                            static_cast<Product::Category>(category.at(i).toInt()),
                                                            nullptr), &QObject::deleteLater);
    }

    if(this->shoplist != shoplist)
    {
        this->shoplist = shoplist;
        emit shoppingListChanged();
    }
}

QVector<QSharedPointer<Product>> * ThingspeakNetManager::getProducts(){
    return &products;
}

QStringList ThingspeakNetManager::getShoppingList(){
    return shoplist;
}

void  ThingspeakNetManager::refreshData()
{
    restclient->get(request);
}

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "datatransfer.h"
#include <QAbstractTableModel>
#include "QtNotification.h"
#include <QQmlContext>
#include "groupproducts.h"
#include "qmldata.h"
#include "productstablemodel.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<QMLdata>("com.mycompany.qmldata", 1, 0, "Qmldata");
    qmlRegisterType<Product>("com.mycompany.product", 1, 0, "Product");
    qmlRegisterType<ProductsTableModel>("com.mycompany.productsTableModel", 1, 0, "ProductsTableModel");

    QQmlApplicationEngine engine;
    DataTransfer dataTransfer;
    QMLdata products(dataTransfer.getProducts());

    //engine.rootContext()->setContextProperty("productsTablet",all_tables->modelek);
    QtNotification::declareQML();
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("ThingspeakData", &products);
    engine.load(url);


    return app.exec();
}

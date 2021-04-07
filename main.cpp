#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "ThinkspeakNetManager.h"
#include <QAbstractTableModel>
#include <QQmlContext>
#include "ManagerQML.h"
#include "ProductsTableModel.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Product>("com.mycompany.product", 1, 0, "Product");
    qmlRegisterType<ProductsTableModel>("com.mycompany.productsTableModel", 1, 0, "ProductsTableModel");
    qmlRegisterType<ManagerQML>("com.mycompany.qmldata", 1, 0, "Qmldata");

    QQmlApplicationEngine engine;
    ThingspeakNetManager dataTransfer;
    ManagerQML products(&dataTransfer);
    QObject::connect(&app, &QGuiApplication::applicationStateChanged,
                     &products, &ManagerQML::saveConfig);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("ManagerQML", &products);
    engine.load(url);

    return app.exec();
}

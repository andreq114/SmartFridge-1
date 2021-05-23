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

    qmlRegisterType<Product>("CppTypes.Product", 1, 0, "Product");
    qmlRegisterType<ProductsTableModel>("CppTypes.ProductsTableModel", 1, 0, "ProductsTableModel");
    qmlRegisterType<ManagerQML>("CppTypes.Qmldata", 1, 0, "ManagerQml");

    QQmlApplicationEngine engine;
    ThingspeakNetManager dataTransfer;
    ManagerQML qmlManager(&dataTransfer);
    QObject::connect(&app, &QGuiApplication::applicationStateChanged,
                     &qmlManager, &ManagerQML::saveConfig);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("ManagerQML", &qmlManager);
    engine.load(url);

    return app.exec();
}

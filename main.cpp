#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "datatransfer.h"
#include <QAbstractTableModel>
#include "QtNotification.h"
#include <QQmlContext>
#include "groupproducts.h"
#include "qmldata.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<GroupProducts>("com.mycompany.groupproducts", 1, 0, "Groupproducts");
    qmlRegisterType<QMLdata>("com.mycompany.qmldata", 1, 0, "Qmldata");
    qmlRegisterType<Product>("com.mycompany.product", 1, 0, "Product");

    QQmlApplicationEngine engine;
    DataTransfer dataTransfer;
    QMLdata products(dataTransfer.getProducts());

    QtNotification::declareQML();
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("products", &products);

    engine.load(url);


    return app.exec();
}

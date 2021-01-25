#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "datatransfer.h"
#include <QAbstractTableModel>
#include "iconstable.h"
#include "QtNotification.h"
#include <QQmlContext>
#include "productstablemodel.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //qmlRegisterType<IconsTable>("TableModel", 0, 1, "TableModel");
    qmlRegisterType<ProductsTableModel>("com.ProductsTable",0,1,"ProductsTable");

    QQmlApplicationEngine engine;
    QtNotification::declareQML();
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    DataTransfer data;
    return app.exec();
}

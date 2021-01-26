#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "datatransfer.h"
#include <QAbstractTableModel>
#include "iconstable.h"
#include "QtNotification.h"
#include <QQmlContext>
#include "productstablemodel.h"
#include "productstables.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    //ProductsTableModel *productsTable = new ProductsTableModel();
    //qmlRegisterType<IconsTable>("TableModel", 0, 1, "TableModel");
    //qmlRegisterType<ProductsTableModel>("com.ProductsTable",0,1,"ProductsTable");

    QQmlApplicationEngine engine;
    ProductsTables *all_tables = new ProductsTables;
    engine.rootContext()->setContextProperty("dairyModel",all_tables->dairyModel);
    engine.rootContext()->setContextProperty("fishModel",all_tables->fishModel);
    engine.rootContext()->setContextProperty("frozenModel",all_tables->frozenModel);
    engine.rootContext()->setContextProperty("fruitsModel",all_tables->fruitsModel);

    //engine.rootContext()->setContextProperty("productsTablet",all_tables->modelek);
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

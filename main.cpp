#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "datatransfer.h"
#include <QAbstractTableModel>
#include "QtNotification.h"
#include <QQmlContext>
#include "groupproducts.h"
#include "qmldata.h"
#include "productstablemodel.h"
#include <QtAndroid>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    auto  result = QtAndroid::checkPermission(QString("android.permission.WRITE_EXTERNAL_STORAGE"));
        if(result == QtAndroid::PermissionResult::Denied){
            QtAndroid::PermissionResultMap resultHash = QtAndroid::requestPermissionsSync(QStringList({"android.permission.WRITE_EXTERNAL_STORAGE"}));
            if(resultHash["android.permission.WRITE_EXTERNAL_STORAGE"] == QtAndroid::PermissionResult::Denied)
                return 0;
   }

    qmlRegisterType<Product>("com.mycompany.product", 1, 0, "Product");
    qmlRegisterType<ProductsTableModel>("com.mycompany.productsTableModel", 1, 0, "ProductsTableModel");
    qmlRegisterType<QMLdata>("com.mycompany.qmldata", 1, 0, "Qmldata");

    QQmlApplicationEngine engine;
    DataTransfer dataTransfer;
    QMLdata products(&dataTransfer);


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

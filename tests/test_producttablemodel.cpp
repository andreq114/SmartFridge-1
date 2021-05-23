#include "test_producttablemodel.h"
#include <QtTest\QtTest>
#include <QDate>
#include "ProductsTableModel.h"

void Test_ProductTableModel::tst_addProduct()
{
    bool red = true;
    bool yellow = true;
    ProductsTableModel tableModel;
    tableModel.addProduct("Mleko", QDate::fromString("11.06.2021", "dd.MM.yyyy"), &red, &yellow);
    tableModel.addProduct("Mleko", QDate::fromString("15.07.2022", "dd.MM.yyyy"), &red, &yellow);
    tableModel.addProduct("Jogurt", QDate::fromString("19.11.2022", "dd.MM.yyyy"), &red, &yellow);
    tableModel.sortModel();
    qDebug() << tableModel.data(tableModel.index(0,0));
    QVERIFY(true);
}

QTEST_MAIN(Test_ProductTableModel)
#include "test_producttablemodel.moc"

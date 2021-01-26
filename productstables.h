#ifndef PRODUCTSTABLES_H
#define PRODUCTSTABLES_H

#define CATEGORYS_NUMBER 11
#include "productstablemodel.h"
#include <QVector>
#include <QList>
#include <QQmlContext>

class ProductsTables
{

public:
    ProductsTables();
    //ProductsTableModel *productsList = new ProductsTableModel[2];

    void addProducts(QString description,QString exp_date,int category);
    ProductsTableModel *fishModel = new ProductsTableModel;
    ProductsTableModel *dairyModel = new ProductsTableModel;
    ProductsTableModel *frozenModel = new ProductsTableModel;
    ProductsTableModel *fruitsModel = new ProductsTableModel;
    ProductsTableModel *meatsModel = new ProductsTableModel;
    ProductsTableModel *waterModel = new ProductsTableModel;
    ProductsTableModel *saucesModel = new ProductsTableModel;
    ProductsTableModel *drinksModel = new ProductsTableModel;
    ProductsTableModel *sweetsModel = new ProductsTableModel;
    ProductsTableModel *alcoholsModel = new ProductsTableModel;
private:



};

#endif // PRODUCTSTABLES_H

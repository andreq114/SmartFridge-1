#include "productstables.h"
#include <QDebug>

ProductsTables::ProductsTables()
{
    //for(auto i=0;i<CATEGORYS_NUMBER;i++){
    //modelik = new ProductsTableModel;
        //productsList.append(modelik);

    //}
    //addProducts("piwerko","z puchy",5);

    //productsList[0].addProduct("piwerko","z puchy");

    //productsList[1].addProduct("woda","z flachy");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");
    dairyModel->addProduct("mleko","exp_date");

    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");
    fishModel->addProduct("rybka","exp_date");


    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");
    frozenModel->addProduct("mrozonka","exp_date");


    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");
    fruitsModel->addProduct("owoce","exp_date");



    //modelek->addProduct("wóda","zz flachy");

}

void ProductsTables::addProducts(QString description,QString exp_date,int category){
    //modelik->addProduct(description,exp_date);
}

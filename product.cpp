#include "product.h"

Product::Product(QString     name,
                 QDate       term,
                 Category    category,
                 QObject *parent)
                : QObject(parent), name(name), term(term), category(category)
{

}


Product::Product(QObject *parent) : QObject(parent) {

}

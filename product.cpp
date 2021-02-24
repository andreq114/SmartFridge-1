#include "product.h"

Product::Product(QString     name,
                 QString     company,
                 QString     desc,
                 QString     mass,
                 QDate       term,
                 Category    category,
                 QObject *parent)
                : QObject(parent), name(name), company(company), desc(desc), mass(mass), term(term), category(category)
{

}


Product::Product(QObject *parent)
    : QObject(parent), name("Unkown"), company(""), desc(""), mass(""), term(QDate()), category(Category::EndOfExpiry)
{

}

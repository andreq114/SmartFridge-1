#ifndef TABLEPRODUCT_H
#define TABLEPRODUCT_H

#include <QObject>
#include <QDateTime>

struct TableProduct{
    QString description;
    QDateTime exp_date;
    bool aVisible;
    bool *redTerm;
    bool *yellowTerm;
};

#endif // TABLEPRODUCT_H

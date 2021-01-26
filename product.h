#ifndef PRODUCT_H
#define PRODUCT_H

#include <QObject>
#include <QDate>

class Product : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString term READ getTerm NOTIFY termChanged)
    Q_PROPERTY(QString name READ getName NOTIFY nameChanged)
public:
    enum Category{
        Dairy,
        Drinks,
        Alcohols,
        Sauces,
        Sweets,
        Fishes,
        Meat,
        Frozen,
        Plants
    };
    Q_FLAG(Category)
    explicit Product(QObject *parent = nullptr);
    explicit Product(QString     name,
                    QDate       term,
                    Category    category,
                    QObject *parent = nullptr);


    QString getTerm() const {return term.toString();}
//  QDate getTerm() const {return term;}
    QString getName() const {return name;}
    Category getCat() const {return category;}
signals:
    void nameChanged();
    void termChanged();

private:
    QString     name;
    QDate       term;
    Category    category;




};

#endif // PRODUCT_H

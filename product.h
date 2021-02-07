#ifndef PRODUCT_H
#define PRODUCT_H

#include <QObject>
#include <QDate>

class Product : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString term READ getTerm NOTIFY termChanged)
    Q_PROPERTY(QString name READ getFullName NOTIFY nameChanged)
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
                     QString     company,
                     QString     desc,
                     QString     mass,
                    QDate       term,
                    Category    category,
                    QObject *parent = nullptr);


    QString getTerm() const {return term.toString();}
//  QDate getTerm() const {return term;}
    QString getFullName() const {return name + ' ' + company + ' ' + desc + ' ' + mass;}
    Category getCat() const {return category;}
signals:
    void nameChanged();
    void termChanged();

private:
    QString     name;
    QString     company;
    QString     desc;
    QString     mass;
    QDate       term;
    Category    category;




};

#endif // PRODUCT_H

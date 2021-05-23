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
        Plants,
        EndOfExpiry
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


    QString     getTerm() const {return term.toString();}
    QDate       getDate() const {return term;}
    QString     getFullName() const {return name + ' ' + company + ' ' + desc + ' ' + mass;}
    Category    getCategory() const {return category;}
    bool*       getRedTerm() {return &redTerm;}
    void        setRedTerm(bool val) {redTerm = val;}
    bool*       getYellowTerm() {return &yellowTerm;}
    void        setYellowTerm(bool val) {yellowTerm = val;}
signals:
    void        nameChanged();
    void        termChanged();

private:
    QString     name;
    QString     company;
    QString     desc;
    QString     mass;
    QDate       term;
    Category    category;
    bool        redTerm = false;
    bool        yellowTerm = false;
};

#endif // PRODUCT_H

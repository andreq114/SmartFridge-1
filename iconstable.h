#ifndef ICONSTABLE_H
#define ICONSTABLE_H
#include <QAbstractTableModel>

class IconsTable : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit IconsTable(QAbstractTableModel *parent = nullptr);

    int rowCount(const QModelIndex & = QModelIndex()) const override
    {
        return 10;
    }

    int columnCount(const QModelIndex & = QModelIndex()) const override
    {
        return 10;
    }

    QVariant data(const QModelIndex &index, int role) const override
    {
        switch (role) {
            case Qt::DisplayRole:
                return QString("%1, %2").arg(index.column()).arg(index.row());
            default:
                break;
        }

        return QVariant();
    }

    QHash<int, QByteArray> roleNames() const override
    {
        return { {Qt::DisplayRole, "display"} };
    }
signals:

};

#endif // ICONSTABLE_H

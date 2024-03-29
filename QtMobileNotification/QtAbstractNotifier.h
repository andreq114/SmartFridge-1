
#ifndef QTABSTRACTNOTIFICATOR
#define QTABSTRACTNOTIFICATOR

#include <QObject>

/**
 * @class QtAbstractNotifier The interface for generic notification
 * @brief The class which contains properties for notifications such as
 *        hide, show notifications
 *
 * Each method returns a boolean indicating whether the notifications are
 * supported or not
 */

class QtAbstractNotifier : public QObject
{
    Q_OBJECT

public:
    virtual bool show(const QVariant &notificationParameters) = 0;
    virtual void clear() = 0;
};


#endif // QTABSTRACTNOTIFICATOR


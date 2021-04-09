#ifndef QTIOSNotifier_H
#define QTIOSNotifier_H

#include "QtAbstractNotifier.h"

class QtIosNotifier : public QtAbstractNotifier
{

public:
    QtIosNotifier();

public:
    bool show(const QVariant &notificationParameters);
    void clear();

private:
    void                *m_Delegate;
};

#endif // QTIOSNotifier_H

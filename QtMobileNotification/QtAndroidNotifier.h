#ifndef QTANDROIDNotifier_H
#define QTANDROIDNotifier_H

#include "QtAbstractNotifier.h"

class QtAndroidNotifier : public QtAbstractNotifier
{
public:
    QtAndroidNotifier() {}

public:
    bool show(const QVariant &notificationParameters);
    void clear();
};

#endif // QTANDROIDNotifier_H

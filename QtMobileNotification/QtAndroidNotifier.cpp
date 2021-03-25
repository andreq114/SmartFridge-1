#include "QtAndroidNotifier.h"

#include <QVariant>
#if defined (Q_OS_ANDROID)
    #include <QtAndroid>
#endif


//------------------------------------------------------------------------------

bool QtAndroidNotifier::show(const QVariant &notificationParameters)
{
    QVariantMap parameters = notificationParameters.toMap();
    QString caption = parameters.value("caption", "").toString();
    QString title   = parameters.value("title", "").toString();
    int id          = parameters.value("id", 0).toInt();

#if defined (Q_OS_ANDROID)

    QAndroidJniObject jni_caption = QAndroidJniObject::fromString(caption);
    QAndroidJniObject jni_title   = QAndroidJniObject::fromString(title);

    QAndroidJniObject::callStaticMethod<void>("ru/notifications/javalib/QtAndroidNotifications",
                                              "show",
                                              "(Ljava/lang/String;Ljava/lang/String;I)V",
                                              jni_title.object<jstring>(),
                                              jni_caption.object<jstring>(),
                                              static_cast<jint>(id));
    #endif
    return true;
}

//------------------------------------------------------------------------------

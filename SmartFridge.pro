QT += quick
QT += testlib

android {
    #android-components

    QT += androidextras
}
CONFIG += c++11
CONFIG += testcase
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        src/ManagerQML.cpp \
        src/Product.cpp \
        src/ProductsTableModel.cpp \
        src/ThinkspeakNetManager.cpp \
        src/main.cpp

RESOURCES += qml.qrc


include(QtMobileNotification/QtMobileNotification.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/ManagerQML.h \
    src/Product.h \
    src/ProductsTableModel.h \
    src/ThinkspeakNetManager.h

DISTFILES +=


TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    controllers/graphcontroller.cpp \
    models/csvmodel.cpp \
    helpers/csvfilehandler.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES +=

HEADERS += \
    controllers/graphcontroller.h \
    models/csvmodel.h \
    helpers/csvfilehandler.h

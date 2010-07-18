# -------------------------------------------------
# Project created by QtCreator 2009-12-06T20:13:00
# -------------------------------------------------
TARGET = lolface
TEMPLATE = app
SOURCES += main.cpp \
    mainwindow.cpp \
    keylogger_x11.cpp
HEADERS += mainwindow.h \
    keylogger.h \
    keylogger_x11.h
FORMS += 
unix:LIBS += -lX11
QT += declarative
RESOURCES += resources.qrc
OTHER_FILES += view.qml

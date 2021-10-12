QT += gui widgets

TEMPLATE = lib
CONFIG += plugin

INCLUDEPATH += include

SOURCES += \
    src/NPDialog.cpp \
    src/TemplatePlugin.cpp

HEADERS += \
    include/NPDialog.hpp \
    include/NPGuiInterface.hpp \
    include/TemplatePlugin.hpp

TEMPLATE      = lib
CONFIG       += qt plugin
QT           += declarative
CONFIG += link_pkgconfig duicontrolpanel
PKGCONFIG +=  gq-gconf

HEADERS       = *.h
SOURCES       = *.cpp

TARGET        = qmlgconfplugin
target.path = /usr/share/duicontrolpanel/unrestricted/org/coderus/GConf

plugin.files += org
plugin.path = /usr/share/duicontrolpanel/unrestricted

INSTALLS += target plugin

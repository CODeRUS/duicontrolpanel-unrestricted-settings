TEMPLATE      = lib
CONFIG       += qt plugin
QT           += declarative dbus
CONFIG += link_pkgconfig duicontrolpanel

HEADERS       = *.h
SOURCES       = *.cpp

TARGET        = qmlunrestrictedplugin
target.path = /usr/share/duicontrolpanel/unrestricted/org/coderus/Unrestricted

plugin.files += org
plugin.path = /usr/share/duicontrolpanel/unrestricted

INSTALLS += target plugin

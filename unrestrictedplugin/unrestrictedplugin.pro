TEMPLATE      = lib
CONFIG       += qt plugin
QT           += declarative dbus
CONFIG += link_pkgconfig duicontrolpanel

MOC_DIR	      = .moc
OBJECTS_DIR   = .objects

HEADERS       = *.h
SOURCES       = *.cpp

TARGET        = qmlunrestrictedplugin
DESTDIR       = org/coderus/Unrestricted

plugin.files += org
plugin.path = /usr/share/duicontrolpanel/unrestricted

INSTALLS += plugin
TEMPLATE      = lib
CONFIG       += qt plugin
QT           += declarative
CONFIG += link_pkgconfig duicontrolpanel
PKGCONFIG +=  gq-gconf

MOC_DIR	      = .moc
OBJECTS_DIR   = .objects

HEADERS       = *.h
SOURCES       = *.cpp

TARGET        = qmlgconfplugin
DESTDIR       = org/coderus/GConf

plugin.files += org
plugin.path = /usr/share/duicontrolpanel/unrestricted

INSTALLS += plugin
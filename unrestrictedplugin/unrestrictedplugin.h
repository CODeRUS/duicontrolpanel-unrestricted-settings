#ifndef UNRESTRICTEDPLUGIN_H
#define UNRESTRICTEDPLUGIN_H

#include <QDeclarativeExtensionPlugin>
#include <QVariant>
#include <QStringList>
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QProcess>

class UnrestrictedModel : public QObject
{
    Q_OBJECT

public:
    UnrestrictedModel (QObject* parent = 0);
    Q_INVOKABLE QStringList extensionsAvialable();
    Q_INVOKABLE QStringList extensionsFromList(QString name);
    Q_INVOKABLE void saveExtensionsToList(QStringList items, QString name);
    Q_INVOKABLE void restartSysuid();
    Q_INVOKABLE bool isMenuModern();
    Q_INVOKABLE void setMenuType(bool isModern);
    Q_INVOKABLE void rootAction(QString op);
};

class UnrestrictedPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT
public:
    void registerTypes(const char *uri);
};

#endif // UNRESTRICTEDPLUGIN_H



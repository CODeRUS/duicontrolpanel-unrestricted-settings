#include "unrestrictedplugin.h"

#include <QDeclarativeExtensionPlugin>
#include <qdeclarative.h>
#include <QDBusInterface>
#include <QDBusConnection>

UnrestrictedModel::UnrestrictedModel(QObject *parent) : QObject(parent)
{
}

QStringList UnrestrictedModel::extensionsAvialable()
{
    QDir extensions("/usr/share/meegotouch/applicationextensions");
    QStringList list = extensions.entryList(QStringList() << "statusindicatormenu-*.desktop", QDir::Files, QDir::Name | QDir::IgnoreCase);
    list.removeAll("statusindicatormenu-safemode.desktop");
    return list;
}

QStringList UnrestrictedModel::extensionsFromList(QString name)
{
    QFile ext(QString("/home/user/.status-menu/") + name);
    if (ext.exists() && ext.open(QFile::ReadOnly | QFile::Text)) {
        QTextStream in(&ext);
        QStringList items;
        while (!in.atEnd()) {
            QString line = in.readLine();
            if (line.length() > 0)
                items.append(line);
        }
        items.removeDuplicates();
        ext.close();
        return items;
    }
    return QStringList();
}

void UnrestrictedModel::saveExtensionsToList(QStringList items, QString name)
{
    QFile ext(QString("/home/user/.status-menu/") + name);
    if (ext.open(QFile::WriteOnly | QFile::Text)) {
        QTextStream out(&ext);
        foreach (QString line, items)
            out << line << "\n";
        ext.close();
    }
}

void UnrestrictedModel::restartSysuid()
{
        QDBusInterface *unrestricted = new QDBusInterface("com.nokia.unrestricted", "/menuwindow", "com.nokia.unrestricted",
                                                          QDBusConnection::sessionBus(), this);
        unrestricted->call("resetMenuWidget");
        delete unrestricted;
}

bool UnrestrictedModel::isMenuModern()
{
    QFile conf("/usr/share/themes/blanco/meegotouch/sysuid/sysuid.conf");
    if (conf.exists() && conf.open(QFile::ReadOnly | QFile::Text)) {
        QTextStream in(&conf);
        QString content = in.readAll();
        conf.close();
        if (content.contains("StatusIndicatorMenuDropDownView"))
            return true;
    }
    return false;
}

void UnrestrictedModel::setMenuType(bool isModern)
{
    QString pattern;
    if (isModern)
        rootAction("menu-modern");
    else
        rootAction("menu-classic");
}

void UnrestrictedModel::rootAction(QString op)
{
    QProcess::execute("/usr/share/sysuid/root_helper.sh", QStringList() << op);
}

void UnrestrictedPlugin::registerTypes(const char *uri)
{
    qmlRegisterType<UnrestrictedModel>(uri, 1, 0, "Unrestricted");
}

Q_EXPORT_PLUGIN2(qmlunrestrictedplugin, UnrestrictedPlugin)


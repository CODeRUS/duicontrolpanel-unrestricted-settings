#ifndef GCONFPLUGIN_H
#define GCONFPLUGIN_H

#include <QDeclarativeExtensionPlugin>
#include <QVariant>
#include <gq/GConfItem>
#include <QMap>

class GConfModel : public QObject
{
    Q_OBJECT

public:
    GConfModel (QObject* parent = 0);
    Q_INVOKABLE void set(QString key, QVariant value, bool blockSignals = false);
    Q_INVOKABLE QVariant get(QString key, QVariant def = 0);
    Q_INVOKABLE void addWatcher(QString key);
    Q_INVOKABLE void removeWatcher(QString key);

public slots:
    void gconfChanged();

private:
    QMap<QString, GConfItem*> watchedKeys;

signals:
    void valueChanged(QString key, QVariant value);
};

class GConfPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT
public:
    void registerTypes(const char *uri);
};

#endif // GCONFPLUGIN_H



#include "gconfplugin.h"

#include <QDeclarativeExtensionPlugin>
#include <qdeclarative.h>

GConfModel::GConfModel(QObject *parent) : QObject(parent)
{
}

void GConfModel::set(QString key, QVariant value, bool blockSignals)
{
    if (watchedKeys.contains(key)) {
        GConfItem *temp = watchedKeys.value(key);
        if (blockSignals)
            disconnect(temp, SIGNAL(valueChanged()), this, SLOT(gconfChanged()));
        if (temp->value().type() == QVariant::Int) {
            int val = value.toInt();
            temp->set(val);
        }
        else {
            temp->set(value);
        }
        connect(temp, SIGNAL(valueChanged()), this, SLOT(gconfChanged()));
    }
    else {
        GConfItem *temp = new GConfItem(key, this);
        if (temp->value().type() == QVariant::Int) {
            int val = value.toInt();
            temp->set(val);
        }
        else {
            temp->set(value);
        }
        delete temp;
    }
}

QVariant GConfModel::get(QString key, QVariant def)
{
    GConfItem *temp = new GConfItem(key, this);
    QVariant result = temp->value();
    if (result.isNull() && def != 0) {
        temp->set(def);
        result = def;
    }
    delete temp;
    return result;
}

void GConfModel::addWatcher(QString key)
{
    if (!watchedKeys.contains(key)) {
        GConfItem *temp = new GConfItem(key, this);
        connect(temp, SIGNAL(valueChanged()), this, SLOT(gconfChanged()));
        watchedKeys.insert(key, temp);
        if (!temp->value().isNull())
            Q_EMIT valueChanged(temp->key(), temp->value());
    }
}

void GConfModel::removeWatcher(QString key)
{
    if (watchedKeys.contains(key)) {
        GConfItem *temp = watchedKeys.value(key);
        disconnect(temp, SIGNAL(valueChanged()), this, SLOT(gconfChanged()));
        watchedKeys.remove(key);
    }
}

void GConfModel::gconfChanged()
{
    GConfItem *gconf = qobject_cast<GConfItem *>(sender());
    Q_EMIT valueChanged(gconf->key(), gconf->value());
}

void GConfPlugin::registerTypes(const char *uri)
{
    qmlRegisterType<GConfModel>(uri, 1, 0, "GConf");
}

Q_EXPORT_PLUGIN2(qmlgconfplugin, GConfPlugin)


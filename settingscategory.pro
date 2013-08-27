TEMPLATE = subdirs

SUBDIRS += gconfplugin unrestrictedplugin

category.files = unrestricted.cpcategory
category.path = /usr/share/duicontrolpanel/categories/

desktop.files = netspeed.desktop \
			 	ledapplet.desktop \
			 	statusarea.desktop \
			 	sysuidextensions.desktop
desktop.path = /usr/lib/duicontrolpanel

qml.files = qml/DropDown.qml \
			qml/ExtensionsPage.qml \
			qml/LabeledCheck.qml \
			qml/LabeledRadio.qml \
			qml/LabeledSlider.qml \
			qml/LabeledSwitch.qml \
			qml/Separator.qml \
			qml/Vertical.qml \
			qml/extensions.qml \
			qml/ledapplet.qml \
			qml/netspeed.qml \
			qml/statusarea.qml
qml.path = /usr/share/duicontrolpanel/unrestricted

INSTALLS += category desktop qml


import com.nokia.meego 1.0
import QtQuick 1.1
import org.coderus.GConf 1.0

Column {
    id: root
    property string _DISPLAY_NETSPEED: "/desktop/meego/status_area/display_netspeed"
    property string _NETSPEED_INTERFACE: "/desktop/meego/status_area/netspeed_interface"
    property string _NETSPEED_INTERVAL: "/desktop/meego/status_area/netspeed_update_time"
    property string _NETSPEED_WHEN_ONLINE: "/desktop/meego/status_area/display_netspeed_whenOnline"

    GConf {
        id: gconf
        onValueChanged: {
            switch (key) {
            case _DISPLAY_NETSPEED: {
                netspeedEnabled.checked = value
                break;
            }
            case _NETSPEED_INTERFACE: {
                ifaceRow.iface = value
                break;
            }
            case _NETSPEED_INTERVAL: {
                if (!netspeedInterval.pressed)
                    netspeedInterval.value = value
                break;
            }
            case _NETSPEED_WHEN_ONLINE: {
                netspeedWhenOnline.checked = value
                break;
            }
            }
        }
    }

    Component.onCompleted: {
        gconf.addWatcher(_DISPLAY_NETSPEED)
        gconf.addWatcher(_NETSPEED_INTERFACE)
        gconf.addWatcher(_NETSPEED_INTERVAL)
        gconf.addWatcher(_NETSPEED_WHEN_ONLINE)
    }

    Column {
        id: content
        spacing: 10
        anchors.left: root.left
        anchors.right: root.right
        anchors.leftMargin: 16
        anchors.rightMargin: 16

        Rectangle {
            width: 1
            height: 10
            color: "transparent"
        }

        LabeledSwitch {
            id: netspeedEnabled
            width: parent.width
            text: "Enable netspeed"
            checked: true
            onCheckedChanged: {
                gconf.set(_DISPLAY_NETSPEED, checked)
            }
        }

        LabeledSwitch {
            id: netspeedWhenOnline
            width: parent.width
            text: "Display when online"
            checked: true
            onCheckedChanged: {
                gconf.set(_NETSPEED_WHEN_ONLINE, checked)
            }
        }

        Separator {
            width: parent.width
            title: "Interface"
        }

        ButtonRow {
            id: ifaceRow
            width: parent.width
            property string iface: "gprs0"
            Button {
                id: gprsNet
                text: "GPRS"
                checked: ifaceRow.iface == "gprs0"
                onClicked: {
                    if (checked)
                        gconf.set(_NETSPEED_INTERFACE, "gprs0")
                }
            }
            Button {
                id: wlanNet
                text: "WLAN"
                checked: ifaceRow.iface == "wlan0"
                onClicked: {
                    if (checked)
                        gconf.set(_NETSPEED_INTERFACE, "wlan0")
                }
            }
        }

        Separator {
            width: parent.width
            title: "Update interval (ms)"
        }

        LabeledSlider {
            id: netspeedInterval
            width: parent.width
            text: value
            minimumValue: 100
            maximumValue: 10000
            stepSize: 100
            value: 1000
            onValueChanged: {
                gconf.set(_NETSPEED_INTERVAL, value, true)
            }
        }

        Rectangle {
            width: 1
            height: 10
            color: "transparent"
        }
    }
}
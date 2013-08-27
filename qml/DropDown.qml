import com.nokia.meego 1.0
import QtQuick 1.1
import com.nokia.extras 1.1
import com.nokia.controlpanel 0.1
import org.coderus.GConf 1.0

Page {
    id: root
    orientationLock: PageOrientation.LockPortrait

    property string _DISPLAY_NOTIFICATIONS: "/desktop/meego/status_menu/display_notifications"
    property variant allExtensions: null
    property variant fixedExtensions: null
    property variant pannableExtensions: null

    GConf {
        id: gconf
        onValueChanged: {
            switch (key) {
            case _DISPLAY_NOTIFICATIONS: {
                displayNotifications.checked = value
                break;
            }
            }
        }
    }

    Component.onCompleted: {
        var extensions = helper.extensionsAvialable()
        allExtensions = extensions
        var topItems = helper.extensionsFromList("top-order.conf")
        fixedExtensions = topItems
        var pannableItems = helper.extensionsFromList("pannable-order.conf")
        pannableExtensions = pannableItems

        for (var i = 0; i < fixedExtensions.length; i++) {
            var item = fixedExtensions[i]
            if (allExtensions.indexOf(item) != -1) {
                fixedModel.append({ name: item, active: true, fixed: true })
            }
        }
        for (var i = 0; i < allExtensions.length; i++) {
            var item = allExtensions[i]
            if (fixedExtensions.indexOf(item) == -1) {
                fixedModel.append({ name: item, active: false, fixed: true })
            }
        }

        for (var i = 0; i < pannableExtensions.length; i++) {
            var item = pannableExtensions[i]
            if (allExtensions.indexOf(item) != -1) {
                pannableModel.append({ name: item, active: true, fixed: false })
            }
        }
        for (var i = 0; i < allExtensions.length; i++) {
            var item = allExtensions[i]
            if (pannableExtensions.indexOf(item) == -1) {
                pannableModel.append({ name: item, active: false, fixed: false })
            }
        }

        gconf.addWatcher(_DISPLAY_NOTIFICATIONS)
    }

    function saveFixed() {
        var items = []
        for (var i = 0; i < fixedModel.count; i++) {
            var item = fixedModel.get(i)
            if (item.active)
                items.splice(items.length, 0, item.name)
        }
        helper.saveExtensionsToList(items, "top-order.conf")
    }

    function savePannable() {
        var items = []
        for (var i = 0; i < pannableModel.count; i++) {
            var item = pannableModel.get(i)
            if (item.active)
                items.splice(items.length, 0, item.name)
        }
        helper.saveExtensionsToList(items, "pannable-order.conf")
    }

    ListModel {
        id: fixedModel
    }

    ListModel {
        id: pannableModel
    }

    Component {
        id: listDelegate
        Item {
            width: parent.width
            height: 40

            Label {
                text: model.name.replace("statusindicatormenu-", "").replace(".desktop", "")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 100
                font.pixelSize: 26
                color: model.active ? "white" : "gray"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (model.fixed) {
                        fixedModel.setProperty(index, "active", !model.active)
                        saveFixed()
                    }
                    else {
                        pannableModel.setProperty(index, "active", !model.active)
                        savePannable()
                    }
                }
            }

            Image {
                id: moveUp
                source: "image://theme/icon-m-toolbar-up-white" + (mAreaUp.pressed ? "-selected" : "")
                width: 40
                height: 40
                smooth: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 90
                visible: index > 0

                MouseArea {
                    id: mAreaUp
                    anchors.fill: parent
                    onClicked: {
                        if (model.fixed) {
                            fixedModel.move(index, index-1, 1)
                            saveFixed()
                        }
                        else {
                            pannableModel.move(index, index-1, 1)
                            savePannable()
                        }
                    }
                }
            }


            Image {
                id: moveDown
                source: "image://theme/icon-m-toolbar-down-white" + (mAreaDown.pressed ? "-selected" : "")
                width: 40
                height: 40
                smooth: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                visible: index < listModel.count - 1

                MouseArea {
                    id: mAreaDown
                    anchors.fill: parent
                    onClicked: {
                        if (model.fixed) {
                            fixedModel.move(index, index+1, 1)
                            saveFixed()
                        }
                        else {
                            pannableModel.move(index, index+1, 1)
                            savePannable()
                        }
                    }
                }
            }
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        contentHeight: content.height

        Column {
            id: content
            spacing: 10
            width: parent.width

            DcpPageTitle {
                id: titleLabel
                text: "Modern menu" + (isMenuModern ? " (active)" : " (inactive)")
            }

            Separator {
                width: parent.width
                title: "Main settings"
            }

            LabeledSwitch {
                id: displayNotifications
                width: parent.width
                text: "Display notifications"
                onCheckedChanged: {
                    gconf.set(_DISPLAY_NOTIFICATIONS, checked)
                }
            }

            Separator {
                width: parent.width
                title: "Fixed rows"
            }

            Repeater {
                id: fixedList
                model: fixedModel
                width: parent.width
                delegate: listDelegate
            }

            Separator {
                width: parent.width
                title: "Flickable rows"
            }

            Repeater {
                id: pannableList
                model: pannableModel
                width: parent.width
                delegate: listDelegate
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}

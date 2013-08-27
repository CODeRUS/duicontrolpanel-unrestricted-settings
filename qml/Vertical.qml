import com.nokia.meego 1.0
import QtQuick 1.1
import com.nokia.extras 1.1
import com.nokia.controlpanel 0.1

Page {
    id: root
    orientationLock: PageOrientation.LockPortrait
    property variant allExtensions: null
    property variant activeExtensions: null

    Component.onCompleted: {
        var extensions = helper.extensionsAvialable()
        allExtensions = extensions
        var active = helper.extensionsFromList("items-order.conf")
        activeExtensions = active
        //testLabel.text = allExtensions.join("\n")

        for (var i = 0; i < activeExtensions.length; i++) {
            var item = activeExtensions[i]
            if (allExtensions.indexOf(item) != -1) {
                listModel.append({ name: item, active: true })
            }
        }
        for (var i = 0; i < allExtensions.length; i++) {
            var item = allExtensions[i]
            if (activeExtensions.indexOf(item) == -1) {
                listModel.append({ name: item, active: false })
            }
        }
    }

    function saveList() {
        var items = []
        for (var i = 0; i < listModel.count; i++) {
            var item = listModel.get(i)
            if (item.active)
                items.splice(items.length, 0, item.name)
        }
        helper.saveExtensionsToList(items, "items-order.conf")
    }

    ListModel {
        id: listModel
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
                    listModel.setProperty(index, "active", !model.active)
                    saveList()
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
                        listModel.move(index, index-1, 1)
                        saveList()
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
                        listModel.move(index, index+1, 1)
                        saveList()
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
                text: "Standart menu" + (isMenuModern ? " (inactive)" : " (active)")
            }

            Label {
                id: testLabel
                width: parent.width
                wrapMode: Text.WrapAnywhere
            }

            Repeater {
                id: list
                model: listModel
                width: parent.width
                delegate: listDelegate
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}

import QtQuick 1.1
import com.nokia.meego 1.0
import org.coderus.Unrestricted 1.0

Page {
	id: root
    orientationLock: PageOrientation.LockPortrait
    property bool isMenuModern: false

    Component.onCompleted: {
        isMenuModern = helper.isMenuModern()
    }

	tools: ToolBarLayout {
        ToolIcon { iconId: "toolbar-back"; onClicked: Qt.quit()}
        ButtonRow {
            style: TabButtonStyle { }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-list" + (theme.inverted ? "-white" : "")
                tab: verticalStyle
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-column" + (theme.inverted ? "-white" : "")
                tab: dropDownStyle
            }
        }
        ToolIcon { iconId: "toolbar-view-menu"; onClicked: {(menu.status == DialogStatus.Closed)
                 ? menu.open()
                 : menu.close() }}
    }

    TabGroup {
        id: tabGroup

        currentTab: isMenuModern ? dropDownStyle : verticalStyle

        Vertical {
            id: verticalStyle
        }
        DropDown {
            id: dropDownStyle
        }
    }

    Menu {
        id: menu
        MenuLayout {
            MenuItem {
                text: isMenuModern ? "Set standart menu" : "Set modern menu"
                onClicked: {
                    helper.setMenuType(!isMenuModern)
                    isMenuModern = helper.isMenuModern()
                    dim.visible = true
                    dimTimer.start()
                }
            }
            MenuItem {
                text: "Restart sysuid"
                onClicked: helper.restartSysuid()
            }
        }
    }

    Rectangle {
        id: dim
        anchors.fill: root
        color: "#40000000"

        MouseArea {
            anchors.fill: parent
        }

        Label {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 22
            text: "Please wait. Sysuid restarting now..."
        }

        visible: false
    }

    Unrestricted {
        id: helper
    }

    Timer {
        id: dimTimer
        repeat: false
        interval: 10000
        onTriggered: dim.visible = false
    }
} 

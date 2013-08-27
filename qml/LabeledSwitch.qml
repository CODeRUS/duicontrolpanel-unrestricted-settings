import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: root

    property alias text: label.text
    property alias color: label.color
    property alias checked: checkbox.checked
    //signal changed

    height: checkbox.height+10

    MouseArea {
        anchors.fill: parent
        onClicked: checkbox.checked = !checkbox.checked
    }
    Label {
        id: label
        anchors.verticalCenter: checkbox.verticalCenter
        width: parent.width - checkbox.width
        wrapMode: Text.NoWrap
        anchors.left: checkbox.right
        anchors.leftMargin: 12
        font.pixelSize: 26
        color: "white"
    }
    Switch {
        id: checkbox
        anchors.verticalCenter: checkbox.verticalCenter
        anchors.left: parent.left
        //onCheckedChanged: root.changed()
    }
}

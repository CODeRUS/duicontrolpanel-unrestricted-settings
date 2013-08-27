import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: root

    property alias text: label.text
    property alias textColor: label.color
    property alias sliderStyle: slider.platformStyle
    property alias value: slider.value
    property alias minimumValue: slider.minimumValue
    property alias maximumValue: slider.maximumValue
    property alias stepSize: slider.stepSize

    height: visible ? slider.height : 0

    Label {
        id: label
        anchors.verticalCenter: root.verticalCenter
        wrapMode: Text.NoWrap
        anchors.left: root.left
        font.pixelSize: 26
        color: "white"
    }
    Slider {
        id: slider
        anchors.verticalCenter: root.verticalCenter
        valueIndicatorVisible: true
        stepSize: 1
        anchors.left: label.right
        anchors.leftMargin: 6
        anchors.right: root.right
    }
}

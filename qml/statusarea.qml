import com.nokia.meego 1.0
import QtQuick 1.1
import org.coderus.GConf 1.0

Column {
    id: root
    property string _DISPLAY_PERCENTAGE: "/desktop/meego/status_area/display_percentage"
    property string _DISPLAY_NETWORK: "/desktop/meego/status_area/display_network_name"
    property string _DISPLAY_PERCENTAGE_LINE: "/desktop/meego/status_area/display_percentage_line"
    property string _LINE_LEVEL_1: "/desktop/meego/status_area/percentage_line_level_1"
    property string _LINE_LEVEL_2: "/desktop/meego/status_area/percentage_line_level_2"
    property string _LINE_RED: "/desktop/meego/status_area/red_percentage_line"
    property string _LINE_GREEN: "/desktop/meego/status_area/green_percentage_line"
    property string _LINE_BLUE: "/desktop/meego/status_area/blue_percentage_line"
    property string _LINE_RED_2: "/desktop/meego/status_area/red_percentage_line_2"
    property string _LINE_GREEN_2: "/desktop/meego/status_area/green_percentage_line_2"
    property string _LINE_BLUE_2: "/desktop/meego/status_area/blue_percentage_line_2"
    property string _LINE_RED_3: "/desktop/meego/status_area/red_percentage_line_3"
    property string _LINE_GREEN_3: "/desktop/meego/status_area/green_percentage_line_3"
    property string _LINE_BLUE_3: "/desktop/meego/status_area/blue_percentage_line_3"

    GConf {
        id: gconf
        onValueChanged: {
            switch (key) {
            case _DISPLAY_PERCENTAGE: {
                percentageSwitch.checked = value
                break;
            }
            case _DISPLAY_NETWORK: {
                networkSwitch.checked = value
                break;
            }
            case _DISPLAY_PERCENTAGE_LINE: {
                lineSwitch.checked = value
                break;
            }
            case _LINE_RED: {
                if (!redSlider.pressed)
                    redSlider.value = value
                break;
            }
            case _LINE_GREEN: {
                if (!greenSlider.pressed)
                    greenSlider.value = value
                break;
            }
            case _LINE_BLUE: {
                if (!blueSlider.pressed)
                    blueSlider.value = value
                break;
            }
            case _LINE_RED_2: {
                if (!redSlider2.pressed)
                    redSlider2.value = value
                break;
            }
            case _LINE_GREEN_2: {
                if (!greenSlider2.pressed)
                    greenSlider2.value = value
                break;
            }
            case _LINE_BLUE_2: {
                if (!blueSlider2.pressed)
                    blueSlider2.value = value
                break;
            }
            case _LINE_RED_3: {
                if (!redSlider3.pressed)
                    redSlider3.value = value
                break;
            }
            case _LINE_GREEN_3: {
                if (!greenSlider3.pressed)
                    greenSlider3.value = value
                break;
            }
            case _LINE_BLUE_3: {
                if (!blueSlider3.pressed)
                    blueSlider3.value = value
                break;
            }
            case _LINE_LEVEL_1: {
                if (!valueLevel2.pressed)
                    valueLevel2.value = value
                break;
            }
            case _LINE_LEVEL_2: {
                if (!valueLevel3.pressed)
                    valueLevel3.value = value
                break;
            }
            }
        }
    }

    Component.onCompleted: {
        gconf.addWatcher(_DISPLAY_PERCENTAGE)
        gconf.addWatcher(_DISPLAY_NETWORK)
        gconf.addWatcher(_DISPLAY_PERCENTAGE_LINE)
        gconf.addWatcher(_LINE_RED)
        gconf.addWatcher(_LINE_GREEN)
        gconf.addWatcher(_LINE_BLUE)
        gconf.addWatcher(_LINE_RED_2)
        gconf.addWatcher(_LINE_GREEN_2)
        gconf.addWatcher(_LINE_BLUE_2)
        gconf.addWatcher(_LINE_RED_3)
        gconf.addWatcher(_LINE_GREEN_3)
        gconf.addWatcher(_LINE_BLUE_3)
        gconf.addWatcher(_LINE_LEVEL_1)
        gconf.addWatcher(_LINE_LEVEL_2)
    }

    Column {
        id: content
        spacing: 10
        anchors.left: root.left
        anchors.right: root.right
        anchors.leftMargin: 16
        anchors.rightMargin: 16

        Separator {
            width: parent.width
            title: "Display items"
        }

        LabeledSwitch {
            id: percentageSwitch
            width: parent.width
            text: "Percentage"
            checked: false
            onCheckedChanged: {
                gconf.set(_DISPLAY_PERCENTAGE, checked)
            }
        }

        LabeledSwitch {
            id: networkSwitch
            width: parent.width
            text: "Operator name"
            checked: true
            onCheckedChanged: {
                gconf.set(_DISPLAY_NETWORK, checked)
            }
        }

        LabeledSwitch {
            id: lineSwitch
            width: parent.width
            text: "Percentage line"
            checked: true
            onCheckedChanged: {
                gconf.set(_DISPLAY_PERCENTAGE_LINE, checked)
            }
        }

        Separator {
            width: parent.width
            title: "Level 1"
            enabled: lineSwitch.checked
        }

        LabeledSlider {
            id: redSlider
            enabled: lineSwitch.checked
            width: parent.width
            text: "R:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color11-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_RED, value, true)
            }
        }

        LabeledSlider {
            id: greenSlider
            enabled: lineSwitch.checked
            width: parent.width
            text: "G:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color3-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_GREEN, value, true)
            }
        }

        LabeledSlider {
            id: blueSlider
            enabled: lineSwitch.checked
            width: parent.width
            text: "B:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color8-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_BLUE, value, true)
            }
        }

        Rectangle {
            id: colorRect
            enabled: lineSwitch.checked
            width: parent.width
            height: 20
            color: Qt.rgba(redSlider.value / 255, greenSlider.value / 255, blueSlider.value / 255, 1)
        }

        Separator {
            width: parent.width
            title: "Level 2"
            enabled: lineSwitch.checked
        }

        LabeledSlider {
            id: valueLevel2
            enabled: lineSwitch.checked
            width: parent.width
            text: "Level: " + value
            minimumValue: 0
            maximumValue: 100
        }

        LabeledSlider {
            id: redSlider2
            enabled: lineSwitch.checked
            width: parent.width
            text: "R:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color11-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_RED_2, value, true)
            }
        }

        LabeledSlider {
            id: greenSlider2
            enabled: lineSwitch.checked
            width: parent.width
            text: "G:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color3-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_GREEN_2, value, true)
            }
        }

        LabeledSlider {
            id: blueSlider2
            enabled: lineSwitch.checked
            width: parent.width
            text: "B:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color8-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_BLUE_2, value, true)
            }
        }

        Rectangle {
            id: colorRect2
            enabled: lineSwitch.checked
            width: parent.width
            height: 20
            color: Qt.rgba(redSlider2.value / 255, greenSlider2.value / 255, blueSlider2.value / 255, 1)
        }

        Separator {
            width: parent.width
            title: "Level 3"
            enabled: lineSwitch.checked
        }

        LabeledSlider {
            id: valueLevel3
            enabled: lineSwitch.checked
            width: parent.width
            text: "Level: " + value
            minimumValue: 0
            maximumValue: 100
        }

        LabeledSlider {
            id: redSlider3
            enabled: lineSwitch.checked
            width: parent.width
            text: "R:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color11-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_RED_3, value, true)
            }
        }

        LabeledSlider {
            id: greenSlider3
            enabled: lineSwitch.checked
            width: parent.width
            text: "G:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color3-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_GREEN_3, value, true)
            }
        }

        LabeledSlider {
            id: blueSlider3
            enabled: lineSwitch.checked
            width: parent.width
            text: "B:"
            sliderStyle: SliderStyle {
                grooveItemElapsedBackground: "image://theme/color8-meegotouch-slider-elapsed-inverted-background-horizontal"
            }
            minimumValue: 0
            maximumValue: 255
            onValueChanged: {
                gconf.set(_LINE_BLUE_3, value, true)
            }
        }

        Rectangle {
            id: colorRect3
            enabled: lineSwitch.checked
            width: parent.width
            height: 20
            color: Qt.rgba(redSlider3.value / 255, greenSlider3.value / 255, blueSlider3.value / 255, 1)
        }

        Rectangle {
            id: spacing
            width: 1
            height: 10
            color: "transparent"
        }
    }
}
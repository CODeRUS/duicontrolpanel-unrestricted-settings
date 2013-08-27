import com.nokia.meego 1.0
import QtQuick 1.1
import org.coderus.GConf 1.0

Column {
    id: root
    property string _LED_ENABLED: "/desktop/meego/notifications/led_enabled"
    property variant ledsAllowed: null

    GConf {
        id: gconf
        onValueChanged: {
            switch (key) {
            case _LED_ENABLED: {
                ledsAllowed = value
                getLeds()
                break;
            }
            }
        }
    }

    Component.onCompleted: {
        gconf.addWatcher(_LED_ENABLED)
    }

    function setLeds() {
        var array = []
        if (ledCall.checked)
            array.push("call")
        if (ledIm.checked)
            array.push("chat")
        if (ledText.checked)
            array.push("sms")
        if (ledVoice.checked)
            array.push("voicemail")
        if (ledEmail.checked)
            array.push("email")
        if (ledFacebook.checked)
            array.push("facebook")
        if (ledTwitter.checked)
            array.push("twitter")
        if (ledOrganiser.checked)
            array.push("organizer")
        if (ledWazapp.checked)
            array.push("wazapp")
        if (ledRocket.checked)
            array.push("rocket")
        gconf.set(_LED_ENABLED, array)
    }

    function getLeds() {
        var array = []
        if (typeof(ledsAllowed) != "undefined") {
            array = array.concat(ledsAllowed)
            ledCall.checked = array.indexOf("call") != -1
            ledIm.checked = array.indexOf("chat") != -1
            ledText.checked = array.indexOf("sms") != -1
            ledVoice.checked = array.indexOf("voicemail") != -1
            ledEmail.checked = array.indexOf("email") != -1
            ledFacebook.checked = array.indexOf("facebook") != -1
            ledTwitter.checked = array.indexOf("twitter") != -1
            ledOrganiser.checked = array.indexOf("organizer") != -1
            ledWazapp.checked = array.indexOf("wazapp") != -1
            ledRocket.checked = array.indexOf("rocket") != -1
        }
        else {
            ledCall.checked = true
            ledIm.checked = true
            ledText.checked = true
            ledVoice.checked = true
            ledEmail.checked = true
            ledFacebook.checked = true
            ledTwitter.checked = true
            ledOrganiser.checked = true
            ledWazapp.checked = true
            ledRocket.checked = true
        }
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

        Separator {
            id: separator
            width: parent.width
            title: "Notify about"
        }

        LabeledSwitch {
            id: ledCall
            width: parent.width
            text: "Missed calls"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledIm
            width: parent.width
            text: "Unread IMs"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledText
            width: parent.width
            text: "Unread text messages"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledVoice
            width: parent.width
            text: "New voicemails"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledEmail
            width: parent.width
            text: "Unread emails"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledFacebook
            width: parent.width
            text: "Facebook events"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledTwitter
            width: parent.width
            text: "Twitter events"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledOrganiser
            width: parent.width
            text: "Missed organiser events"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledWazapp
            width: parent.width
            text: "Wazapp events"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        LabeledSwitch {
            id: ledRocket
            width: parent.width
            text: "Rocket events"
            checked: true
            onCheckedChanged: {
                setLeds()
            }
        }

        Rectangle {
            width: 1
            height: 10
            color: "transparent"
        }
    }
}
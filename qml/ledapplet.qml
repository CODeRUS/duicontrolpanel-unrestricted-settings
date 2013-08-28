import com.nokia.meego 1.0
import QtQuick 1.1
import org.coderus.GConf 1.0

Column {
    id: root
    property string _LED_ENABLED: "/desktop/meego/notifications/led_enabled"
    property variant ledsAllowed: null

    GConf {
        id: gconf
    }

    Component.onCompleted: {
        var leds = []
        leds = gconf.get(_LED_ENABLED, ["call","chat","sms","voicemail","email","facebook","twitter","organizer","wazapp","rocket"])
        getLeds(leds)
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
        if (customNotify.text.length > 0) {
            var array2 = customNotify.text.split(",")
            array = array.concat(array2)
        }
        gconf.set(_LED_ENABLED, array)
    }

    function getLeds(list) {
        ledCall.checked = false
        ledIm.checked = false
        ledText.checked = false
        ledVoice.checked = false
        ledEmail.checked = false
        ledFacebook.checked = false
        ledTwitter.checked = false
        ledOrganiser.checked = false
        ledWazapp.checked = false
        ledRocket.checked = false

        var array = []
        if (typeof(list) != "undefined") {
            array = array.concat(list)
            var custom = []

            for (var i = 0; i < array.length; i ++) {
                var item = array[i]
                if (item == "call") {
                    ledCall.checked = true
                }
                else if (item == "chat") {
                    ledIm.checked = true
                }
                else if (item == "sms") {
                    ledText.checked = true
                }
                else if (item == "voicemail") {
                    ledVoice.checked = true
                }
                else if (item == "email") {
                    ledEmail.checked = true
                }
                else if (item == "facebook") {
                    ledFacebook.checked = true
                }
                else if (item == "twitter") {
                    ledTwitter.checked = true
                }
                else if (item == "organizer") {
                    ledOrganiser.checked = true
                }
                else if (item == "wazapp") {
                    ledWazapp.checked = true
                }
                else if (item == "rocket") {
                    ledRocket.checked = true
                }
                else {
                    custom.splice(0, 0, item)
                }
            }

            customNotify.text = custom.join(",")
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

        Separator {
            width: parent.width
            title: "Custom events"
        }

        TextField {
            id: customNotify
            placeholderText: "custom notifications, comma separated"
            width: parent.width
            onTextChanged: {
                setLeds()
            }
        }

        Label {
            width: parent.width
            text: "List of notifications genericTextCatalogue values, comma separated"
            wrapMode: Text.WordWrap
        }

        Rectangle { 
            width: 1
            height: 10
            color: "transparent"
        }
    }
}

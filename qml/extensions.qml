import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: stackWindow

    Component.onCompleted: {
        theme.inverted = true
    }
    showStatusBar: true
    showToolBar: true


    initialPage: mainPage

    ExtensionsPage {
        id: mainPage
    }
}

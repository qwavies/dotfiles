import QtQuick
import Quickshell
import Quickshell.Io
import qs.widgets

BarText { // TODO: to be changed to pure qml later
    text: "󰣇"
    color: "white"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: wlogoutProc.running = true
    }

    Process {
        id: wlogoutProc
        command: [Quickshell.env("HOME") + "/.config/wlogout/wlogout.sh"]
    }
}

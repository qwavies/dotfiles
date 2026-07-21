import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import qs.widgets

WrapperMouseArea {
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: swayncProc.running = true

    BarWrapper {
        leftMargin: 16
        rightMargin: 16

        BarText {
            text: "" // TODO: show whether or not there are currently notifications

            Process {
                id: swayncProc
                command: ["swaync-client", "-t", "-sw"]
            }

        }
    }

}

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.services
import qs.widgets

RowLayout {
    spacing: 8
    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            id: wsDelegate
            required property var modelData

            implicitHeight: 32
            implicitWidth: 32
            radius: 10
            color: (wsDelegate.modelData.active || mouseArea.containsMouse) ? Theme.blue : Theme.light_blue

            BarText {
                anchors.centerIn: parent
                text: wsDelegate.modelData.id
                color: Theme.crust
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + wsDelegate.modelData.id + " })")
            }

            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}


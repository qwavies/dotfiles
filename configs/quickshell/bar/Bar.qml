import QtQuick
import Quickshell

Variants { // ensures that bar is on all monitors
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        screen: modelData

        anchors {
            top: true
            left: true
            right: true
        }
        margins.top: 4

        implicitHeight: 50
        color: "transparent"

        BarLeft {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 14
            }
        }

        BarMiddle {
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        BarRight {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 14
            }
        }
    }
}

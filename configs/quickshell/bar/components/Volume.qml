import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.services
import qs.widgets

WrapperMouseArea {
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: Audio.toggleMute()
    onWheel: (wheel) => {
        const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
        Audio.setVolume(Math.max(0, Math.min(1, Audio.volume + delta)))
    }

    BarWrapper {

        RowLayout {
            spacing: 6
            BarText {
                text: {
                    if (Audio.muted) return ""
                    if (Audio.isHeadphones) return ""
                    if (Audio.volume < 0.5) return ""
                    return ""
                }
                color: Audio.muted ? Theme.red : Theme.light_blue
            }
            BarText {
                text: Math.round(Audio.volume * 100) + "%"
                color: Audio.muted ? Theme.red : Theme.light_blue
            }
        }

    }

}


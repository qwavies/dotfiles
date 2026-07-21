pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio.muted ?? false
    readonly property string sinkDescription: sink?.description ?? ""
    readonly property bool isHeadphones: sinkDescription.toLowerCase().includes("headphone")

    PwObjectTracker {
        objects: [root.sink]
    }

    function setVolume(volume: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.volume = volume
        }
    }

    function toggleMute(): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = !sink.audio.muted
        }
    }
}

pragma Singleton

import QtQuick
import Quickshell

Singleton {
  readonly property string time: {
    // Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy")
    Qt.formatDateTime(clock.date, "ddd d MMM  ⁺₊  hh:mm AP")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth
import QtQuick

Singleton {
    id: rfkill

    property var radios: ({})
    readonly property var radioList: Object.values(radios)
    readonly property bool airplane: radioList.length > 0 && radioList.every(r => r.soft)
    readonly property bool bluetoothBlocked: radioList.some(r => r.type === 2 && r.soft)
    readonly property var adapter: Bluetooth.defaultAdapter
    property bool bluetoothWanted: false

    Process {
        id: events
        running: true
        command: ["rfkill", "event"]
        stdout: SplitParser {
            onRead: line => rfkill.parse(line)
        }
        onExited: {
            rfkill.radios = {}
            restart.start()
        }
    }

    Timer {
        id: restart
        interval: 2000
        onTriggered: events.running = true
    }

    function parse(line) {
        const m = line.match(/idx (\d+) type (\d+) op (\d+) soft (\d+) hard (\d+)/)
        if (!m) return
        const next = Object.assign({}, radios)
        if (m[3] === "1") delete next[m[1]]
        else next[m[1]] = { type: Number(m[2]), soft: m[4] === "1" }
        radios = next
    }

    function setAirplane(on) {
        if (on) {
            bluetoothWanted = adapter !== null && adapter.enabled
            Quickshell.execDetached(["rfkill", "block", "all"])
        } else {
            Quickshell.execDetached(["rfkill", "unblock", "all"])
        }
    }

    function setBluetooth(on) {
        if (!adapter) return
        if (!on) {
            bluetoothWanted = false
            adapter.enabled = false
            return
        }
        bluetoothWanted = true
        if (bluetoothBlocked) Quickshell.execDetached(["rfkill", "unblock", "bluetooth"])
        else powerOn()
    }

    function powerOn() {
        if (!bluetoothWanted || !adapter || bluetoothBlocked || adapter.state === BluetoothAdapterState.Blocked) return
        bluetoothWanted = false
        adapter.enabled = true
    }

    onBluetoothBlockedChanged: powerOn()

    Connections {
        target: rfkill.adapter
        ignoreUnknownSignals: true
        function onStateChanged() { rfkill.powerOn() }
    }
}

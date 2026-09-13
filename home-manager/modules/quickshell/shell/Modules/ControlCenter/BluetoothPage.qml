import Quickshell
import Quickshell.Bluetooth
import QtQuick
import "../../Config"
import "../../Widgets"
import "../../Services"

Item {
    id: page

    required property var adapter
    signal backRequested()

    property string pairingAddress: ""
    readonly property bool btOn: adapter ? adapter.enabled : false
    readonly property int rowHeight: 36
    readonly property int visibleRows: 6

    width: parent ? parent.width : 0
    height: column.implicitHeight

    function updateDiscovery() {
        if (adapter && adapter.enabled) adapter.discovering = visible
    }
    onVisibleChanged: updateDiscovery()
    onBtOnChanged: updateDiscovery()
    onAdapterChanged: updateDiscovery()

    function icon(d) {
        const i = d.icon || ""
        if (i.startsWith("audio-head") || i === "audio-card") return "󰋋"
        if (i.startsWith("input-keyboard")) return "󰌌"
        if (i.startsWith("input-mouse")) return "󰍽"
        if (i.startsWith("input-gaming")) return "󰊴"
        if (i.startsWith("phone")) return "󰄜"
        if (i.startsWith("computer")) return "󰟀"
        return "󰂯"
    }
    function detail(d) {
        if (d.pairing) return "pairing…"
        switch (d.state) {
        case BluetoothDeviceState.Connecting: return "connecting…"
        case BluetoothDeviceState.Disconnecting: return "disconnecting…"
        case BluetoothDeviceState.Connected:
            return (d.batteryAvailable ? Math.round(d.battery * 100) + "% " : "") + "connected"
        }
        return d.paired ? "paired" : ""
    }
    function activate(d) {
        if (d.pairing) d.cancelPair()
        else if (d.connected) d.disconnect()
        else if (d.paired) d.connect()
        else {
            pairingAddress = d.address
            d.pair()
        }
    }

    readonly property var sorted: {
        if (!adapter) return []
        return adapter.devices.values
            .filter(d => d.paired || d.deviceName !== "")
            .sort((a, b) => (b.connected - a.connected)
                || (b.paired - a.paired)
                || a.name.localeCompare(b.name))
    }

    Column {
        id: column
        width: parent.width

        Rectangle { width: parent.width; height: Style.border; color: Colors.base0C }

        Item {
            width: parent.width
            height: 50

            BarButton {
                id: back
                x: 10 + Style.shadow
                width: 40
                hPadding: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Style.shadow / 2
                text: "󰁍"
                bg: Colors.base03
                hoverBg: Colors.base0C
                hoverFg: Colors.base00
                onClicked: page.backRequested()
            }
            Label {
                anchors.left: back.right
                anchors.leftMargin: 10 + Style.shadow
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Style.shadow / 2
                text: "Bluetooth"
            }
            BarButton {
                anchors.right: parent.right
                anchors.rightMargin: 10 + Style.shadow
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Style.shadow / 2
                width: 70
                text: page.btOn ? "on" : "off"
                active: page.btOn
                bg: Colors.base03
                activeBg: Colors.base0B
                activeFg: Colors.base00
                hoverBg: Colors.base0C
                hoverFg: Colors.base00
                onClicked: if (page.adapter) Rfkill.setBluetooth(!page.btOn)
            }
        }

        Label {
            visible: !page.btOn || page.sorted.length === 0
            width: parent.width
            height: visible ? 40 : 0
            font.bold: false
            color: Colors.base04
            text: !page.adapter ? "no Bluetooth adapter" : (!page.btOn ? "Bluetooth is off" : "searching…")
        }

        ListView {
            id: list
            visible: page.btOn && page.sorted.length > 0
            width: parent.width
            height: visible ? Math.min(contentHeight, page.visibleRows * page.rowHeight) : 0
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model: ScriptModel { values: page.sorted }

            delegate: ListRow {
                id: devRow
                required property var modelData
                width: list.width
                implicitHeight: page.rowHeight
                icon: page.icon(modelData)
                title: modelData.name
                detail: page.detail(modelData)
                highlighted: modelData.connected
                onClicked: page.activate(modelData)
                onRightClicked: if (modelData.paired) modelData.forget()

                Connections {
                    target: devRow.modelData
                    function onPairedChanged() {
                        const d = devRow.modelData
                        if (d.paired && d.address === page.pairingAddress) {
                            page.pairingAddress = ""
                            d.trusted = true
                            d.connect()
                        }
                    }
                }
            }
        }

        Item { width: 1; height: 10 }
    }
}

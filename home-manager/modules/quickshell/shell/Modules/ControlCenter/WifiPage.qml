import Quickshell
import Quickshell.Networking
import QtQuick
import "../../Config"
import "../../Widgets"

Item {
    id: page

    required property var device
    signal backRequested()

    property var pending: null
    property string message: ""
    readonly property bool typing: pending !== null
    readonly property bool wifiOn: Networking.wifiEnabled
    readonly property int rowHeight: 36
    readonly property int visibleRows: 6

    width: parent ? parent.width : 0
    height: column.implicitHeight

    function updateScanner() {
        if (device) device.scannerEnabled = visible && wifiOn
    }
    onVisibleChanged: {
        updateScanner()
        if (!visible) { pending = null; message = ""; field.text = "" }
    }
    onWifiOnChanged: updateScanner()
    onDeviceChanged: updateScanner()

    function signalIcon(n) {
        const s = n.signalStrength * 100
        return s < 25 ? "󰤟" : s < 50 ? "󰤢" : s < 75 ? "󰤥" : "󰤨"
    }
    function secured(n) { return n.security !== WifiSecurityType.Open }
    function detail(n) {
        if (n.stateChanging) return n.state === ConnectionState.Disconnecting ? "disconnecting…" : "connecting…"
        if (n.connected) return "connected"
        return (n.known ? "saved " : "") + (secured(n) ? "󰌾" : "")
    }

    function activate(n) {
        message = ""
        if (n.connected) n.disconnect()
        else if (n.known || !secured(n)) n.connect()
        else {
            pending = n
            field.text = ""
            Qt.callLater(() => field.forceActiveFocus())
        }
    }
    function submit() {
        if (!pending || field.text === "") return
        pending.connectWithPsk(field.text)
        field.text = ""
        pending = null
    }
    function cancel() {
        field.text = ""
        pending = null
    }

    readonly property var sorted: {
        if (!device) return []
        return device.networks.values
            .filter(n => n.name !== "")
            .sort((a, b) => (b.connected - a.connected)
                || (b.known - a.known)
                || a.name.localeCompare(b.name))
    }

    Column {
        id: column
        width: parent.width

        Rectangle { width: parent.width; height: Style.border; color: Colors.base05 }

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
                bg: Colors.base02
                hoverBg: active ? Colors.base04 : Colors.base03
                hoverFg: active ? Colors.base00 : Colors.base05
                onClicked: page.backRequested()
            }
            Label {
                anchors.left: back.right
                anchors.leftMargin: 10 + Style.shadow
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Style.shadow / 2
                text: "Wi-Fi"
            }
            BarButton {
                anchors.right: parent.right
                anchors.rightMargin: 10 + Style.shadow
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Style.shadow / 2
                width: 70
                text: page.wifiOn ? "on" : "off"
                active: page.wifiOn
                bg: Colors.base02
                activeBg: Colors.base05
                activeFg: Colors.base00
                hoverBg: active ? Colors.base04 : Colors.base03
                hoverFg: active ? Colors.base00 : Colors.base05
                onClicked: Networking.wifiEnabled = !Networking.wifiEnabled
            }
        }

        Label {
            visible: !page.wifiOn || page.sorted.length === 0
            width: parent.width
            height: visible ? 40 : 0
            font.bold: false
            color: Colors.base04
            text: !page.wifiOn ? "Wi-Fi is off" : (page.device ? "scanning…" : "no Wi-Fi device")
        }

        ListView {
            id: list
            visible: page.wifiOn && page.sorted.length > 0
            width: parent.width
            height: visible ? Math.min(contentHeight, page.visibleRows * page.rowHeight) : 0
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model: ScriptModel { values: page.sorted }

            delegate: ListRow {
                id: netRow
                required property var modelData
                width: list.width
                implicitHeight: page.rowHeight
                icon: page.signalIcon(modelData)
                title: modelData.name
                detail: page.detail(modelData)
                highlighted: modelData.connected || page.pending === modelData
                onClicked: page.activate(modelData)
                onRightClicked: if (modelData.known && !modelData.connected) modelData.forget()

                Connections {
                    target: netRow.modelData
                    function onConnectionFailed(reason) {
                        page.message = netRow.modelData.name + ": "
                            + (reason === ConnectionFailReason.NoSecrets ? "wrong or missing password" : ConnectionFailReason.toString(reason))
                    }
                }
            }
        }

        Item {
            visible: page.typing
            width: parent.width
            height: visible ? 50 : 0

            Rectangle {
                x: 10
                width: parent.width - 20
                height: 38
                anchors.verticalCenter: parent.verticalCenter
                color: Qt.alpha(Colors.base01, Style.bgAlpha)
                border.width: Style.border
                border.color: Colors.base05

                TextInput {
                    id: field
                    anchors.fill: parent
                    anchors.leftMargin: Style.border + 8
                    anchors.rightMargin: Style.border + 8
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    clip: true
                    color: Colors.base05
                    selectionColor: Colors.base03
                    font.family: Style.fontFamily
                    font.pointSize: Style.fontSize
                    font.bold: true
                    Keys.onReturnPressed: page.submit()
                    Keys.onEnterPressed: page.submit()
                    Keys.onEscapePressed: page.cancel()
                }
                Label {
                    anchors.fill: field
                    visible: field.text === ""
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                    font.bold: false
                    color: Colors.base03
                    text: "password for " + (page.pending ? page.pending.name : "")
                }
            }
        }

        Label {
            visible: page.message !== ""
            width: parent.width - 20
            x: 10
            height: visible ? 30 : 0
            horizontalAlignment: Text.AlignLeft
            elide: Text.ElideRight
            font.bold: false
            color: Colors.base08
            text: page.message
        }

        Item { width: 1; height: 10 }
    }
}

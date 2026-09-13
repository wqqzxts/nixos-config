import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Networking
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Effects
import "../Config"
import "../Services"
import "../Widgets"
import "ControlCenter"

BarModule {
    id: controlCenter
    widgetWidth: 430
    borderColor: Colors.base0C

    signal hideRequested()

    property string page: "main"
    readonly property bool wantsKeyboard: page === "wifi" && wifiPage.typing
    property bool held: false
    pinned: wantsKeyboard || held
    onHoveredChanged: if (!hovered) held = false
    onClosed: page = "main"

    function openThemePage() {
        page = "theme"
        held = true
    }
    function closeThemePage() {
        held = false
        if (!hovered) page = "main"
    }
    function toggleThemePage() {
        if (open && page === "theme") closeThemePage()
        else openThemePage()
    }

    readonly property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi) ?? null
    readonly property var wifiNetwork: wifiDevice ? (wifiDevice.networks.values.find(n => n.connected) ?? null) : null
    readonly property bool wired: Networking.devices.values.some(d => d.type === DeviceType.Wired && d.connected)
    readonly property bool wifiOn: Networking.wifiEnabled
    readonly property string essid: wifiNetwork ? wifiNetwork.name : ""
    readonly property int wifiSignal: {
        if (!wifiNetwork) return 0
        const s = wifiNetwork.signalStrength
        return Math.round(s <= 1 ? s * 100 : s)
    }

    function networkIcon(noSignalGlyph) {
        if (wired) return "󰈀"
        if (!wifiOn) return "󰤮"
        if (essid === "") return noSignalGlyph
        if (wifiSignal < 25) return "󰤟"
        if (wifiSignal < 50) return "󰤢"
        if (wifiSignal < 75) return "󰤥"
        return "󰤨"
    }

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property bool btOn: adapter ? adapter.enabled : false

    readonly property var sink: Pipewire.defaultAudioSink
    PwObjectTracker { objects: controlCenter.sink ? [controlCenter.sink] : [] }
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property int volume: sink && sink.audio ? Math.round(sink.audio.volume * 100) : 0

    function volumeIcon() {
        if (muted) return "󰝟"
        return volume < 33 ? "󰖀" : "󰕾"
    }

    property string backlight: ""
    Process {
        running: true
        command: ["sh", "-c", "ls /sys/class/backlight | head -n1"]
        stdout: StdioCollector { onStreamFinished: controlCenter.backlight = text.trim() }
    }
    FileView {
        id: maxBrightness
        path: controlCenter.backlight ? "/sys/class/backlight/" + controlCenter.backlight + "/max_brightness" : ""
        printErrors: false
    }
    FileView {
        id: curBrightness
        path: controlCenter.backlight ? "/sys/class/backlight/" + controlCenter.backlight + "/brightness" : ""
        printErrors: false
        watchChanges: true
        onFileChanged: reload()
    }
    readonly property int brightness: {
        const max = parseInt(maxBrightness.text()), cur = parseInt(curBrightness.text())
        return max > 0 && cur >= 0 ? Math.round(cur / max * 100) : 0
    }

    function brightnessIcon() {
        if (brightness === 0) return "󰛩"
        if (brightness > 90) return "󰛨"
        return ["󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖"][Math.floor((brightness - 1) / 10)]
    }

    readonly property bool dnd: Notifs.dnd
    readonly property int unseen: Notifs.history.length

    widgetContent: Row {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        Repeater {
            model: [
                controlCenter.networkIcon("󰤯"),
                controlCenter.btOn ? "󰂯" : "󰂲",
                controlCenter.volumeIcon(),
                controlCenter.brightnessIcon(),
                controlCenter.dnd ? "󰂛" : (controlCenter.unseen > 0 ? "󱅫" : "󰂚")
            ]
            Label {
                required property string modelData
                width: parent.width / 5
                height: parent.height
                text: modelData
            }
        }
    }

    component SliderRow: Item {
        id: row
        property string icon
        property real value: 0
        property bool active: true
        signal moved(real value)
        width: parent.width
        height: implicitHeight
        implicitHeight: 20 + 2 * 10
        Label {
            id: iconLabel
            x: 15
            anchors.verticalCenter: parent.verticalCenter
            text: row.icon
        }
        BarSlider {
            anchors.verticalCenter: parent.verticalCenter
            x: 15 + iconLabel.implicitWidth + 15
            width: row.width - x - 15
            value: row.value
            active: row.active
            onMoved: v => row.moved(v)
        }
    }

    component SettingButton: BarButton {
        width: (settings.width - 2 * settings.margin - grid.columnSpacing) / 2
        textAlign: Text.AlignLeft
        bg: Colors.base03
        fg: Colors.base05
        activeBg: Colors.base0B
        activeFg: Colors.base00
        hoverBg: Colors.base0C
        hoverFg: Colors.base00
    }

    WifiPage {
        id: wifiPage
        visible: controlCenter.page === "wifi"
        device: controlCenter.wifiDevice
        onBackRequested: controlCenter.page = "main"
    }

    BluetoothPage {
        visible: controlCenter.page === "bt"
        adapter: controlCenter.adapter
        onBackRequested: controlCenter.page = "main"
    }

    ThemePage {
        visible: controlCenter.page === "theme"
        onBackRequested: {
            controlCenter.held = false
            controlCenter.page = "main"
        }
    }

    SliderRow {
        id: volumeRow
        visible: controlCenter.page === "main"
        icon: controlCenter.volumeIcon()
        active: !controlCenter.muted
        value: controlCenter.muted ? 0 : controlCenter.volume
        onMoved: v => { if (controlCenter.sink && controlCenter.sink.audio) controlCenter.sink.audio.volume = v / 100 }
    }

    SliderRow {
        id: brightnessRow
        visible: controlCenter.page === "main"
        icon: controlCenter.brightnessIcon()
        value: controlCenter.brightness
        onMoved: v => Quickshell.execDetached(["brightnessctl", "-q", "set", Math.round(v) + "%"])
    }

    Item {
        id: settings
        visible: controlCenter.page === "main"
        width: parent.width
        height: implicitHeight
        readonly property int margin: 10 + Style.shadow
        implicitHeight: Style.border + 10 + grid.implicitHeight + Style.shadow + 10

        Rectangle { width: parent.width; height: Style.border; color: Colors.base0C }

        Grid {
            id: grid
            x: settings.margin; y: Style.border + 10
            columns: 2
            columnSpacing: 10 + 2 * Style.shadow
            rowSpacing: Style.spacing + Style.shadow

            SettingButton {
                text: controlCenter.networkIcon("󰤫") + "  " + (!controlCenter.wifiOn ? "Wi-Fi off" : (controlCenter.essid === "" ? "not connected" : controlCenter.essid))
                active: controlCenter.wifiOn
                onClicked: controlCenter.page = "wifi"
            }
            SettingButton {
                text: (controlCenter.btOn ? "󰂯" : "󰂲") + "  Bluetooth"
                active: controlCenter.btOn
                onClicked: controlCenter.page = "bt"
            }
            SettingButton {
                text: (controlCenter.dnd ? "󰂛" : "󰂚") + "  Focus"
                active: controlCenter.dnd
                onClicked: Notifs.dnd = !Notifs.dnd
            }
            SettingButton {
                text: (Rfkill.airplane ? "󰀝" : "󰀞") + "  Airplane"
                active: Rfkill.airplane
                onClicked: Rfkill.setAirplane(!Rfkill.airplane)
            }
            SettingButton {
                text: "󰈉  Hide Bar"
                bg: Colors.base0B
                fg: Colors.base00
                onClicked: controlCenter.hideRequested()
            }
            SettingButton {
                text: "󰏘  Theme center"
                bg: Colors.base0B
                fg: Colors.base00
                onClicked: controlCenter.page = "theme"
            }
        }
    }

    Item {
        id: notifs
        visible: controlCenter.page === "main" && controlCenter.unseen > 0
        width: parent.width
        height: visible ? implicitHeight : 0
        implicitHeight: Style.border + 10 + histCol.implicitHeight + 10

        Rectangle { width: parent.width; height: Style.border; color: Colors.base0C }

        Column {
            id: histCol
            x: 10; y: Style.border + 10
            width: parent.width - 20
            spacing: Style.spacing

            Repeater {
                model: Notifs.history.slice(0, 1)
                Rectangle {
                    id: row
                    required property var modelData
                    width: histCol.width
                    clip: true
                    height: rowText.implicitHeight + 2 * 8
                    color: rowMouse.containsMouse ? Colors.base02 : Colors.base01
                    Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }

                    Rectangle { width: Style.border; height: parent.height; color: Notifs.frameColor(row.modelData.urgency) }

                    IconImage {
                        x: Style.border + 10
                        anchors.verticalCenter: parent.verticalCenter
                        implicitSize: 24
                        visible: row.modelData.icon !== ""
                        source: row.modelData.icon
                    }

                    Column {
                        id: rowText
                        x: Style.border + 10 + (row.modelData.icon !== "" ? 24 + 10 : 0)
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - x - 10
                        Label {
                            width: parent.width
                            horizontalAlignment: Text.AlignLeft
                            elide: Text.ElideRight
                            text: row.modelData.summary
                        }
                        Label {
                            width: parent.width
                            visible: row.modelData.body !== ""
                            horizontalAlignment: Text.AlignLeft
                            elide: Text.ElideRight
                            maximumLineCount: 1
                            font.bold: false
                            color: Colors.base04
                            textFormat: Text.StyledText
                            text: row.modelData.body.split("<br>")[0]
                        }
                    }

                    MouseArea {
                        id: rowMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        cursorShape: Qt.PointingHandCursor
                        onClicked: mouse => mouse.button === Qt.RightButton ? Notifs.dismiss(row.modelData) : Notifs.activate(row.modelData)
                    }
                }
            }

            Item {
                width: histCol.width
                height: footer.implicitHeight
                Label {
                    id: footer
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignLeft
                    color: Colors.base03
                    text: controlCenter.unseen > 1 ? "+" + (controlCenter.unseen - 1) + " more unseen" : "1 unseen"
                }
                Label {
                    anchors.right: parent.right
                    visible: controlCenter.unseen > 0
                    color: clearMouse.containsMouse ? Colors.base0C : Colors.base05
                    Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
                    text: "clear"
                    MouseArea {
                        id: clearMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Notifs.clearHistory()
                    }
                }
            }
        }
    }

    Item {
        id: tray
        visible: controlCenter.page === "main"
        width: parent.width
        height: implicitHeight
        implicitHeight: 10 + trayBox.height + 10

        Rectangle {
            id: trayBox
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 20
            height: 2 * Style.border + 2 * 10 + 24
            color: "transparent"
            border.width: Style.border
            border.color: Colors.base0C

            Row {
                anchors.fill: parent
                anchors.margins: Style.border + 5
                Repeater {
                    model: SystemTray.items
                    Item {
                        id: slot
                        required property var modelData
                        width: parent.width / Math.max(1, SystemTray.items.values.length)
                        height: parent.height
                        readonly property bool symbolic: String(modelData.icon).includes("-symbolic")
                        IconImage {
                            id: trayIcon
                            anchors.centerIn: parent
                            implicitSize: 24
                            source: slot.modelData.icon
                        }
                        ShaderEffectSource {
                            id: trayMask
                            sourceItem: trayIcon
                            hideSource: slot.symbolic
                            visible: false
                        }
                        Rectangle {
                            anchors.fill: trayIcon
                            visible: slot.symbolic
                            color: Colors.base05
                            layer.enabled: true
                            layer.effect: MultiEffect {
                                maskEnabled: true
                                maskSource: trayMask
                                maskThresholdMin: 0.5
                                maskSpreadAtMin: 1.0
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                            cursorShape: Qt.PointingHandCursor
                            onClicked: mouse => {
                                if (mouse.button === Qt.RightButton && slot.modelData.hasMenu) {
                                    const p = slot.mapToItem(null, 0, slot.height)
                                    slot.modelData.display(QsWindow.window, p.x, p.y)
                                } else if (mouse.button === Qt.MiddleButton) {
                                    slot.modelData.secondaryActivate()
                                } else {
                                    slot.modelData.activate()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

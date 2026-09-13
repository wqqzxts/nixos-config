import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick
import "../Config"
import "../Services"
import "../Widgets"

BarModule {
    id: dashboard
    borderColor: Colors.base0E

    property string displayMode: "auto"
    readonly property bool playing: player !== null && player.isPlaying
    readonly property string shown: displayMode === "auto" ? (playing ? "cava" : "stats") : displayMode

    function cycleDisplay() {
        const order = ["auto", "combined", "stats"]
        displayMode = order[(order.indexOf(displayMode) + 1) % order.length]
    }

    widgetWidth: shown === "combined" ? 640 : 400
    Behavior on widgetWidth {
        NumberAnimation { duration: Style.animDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve }
    }

    function tempIcon(t) {
        if (t < 30) return ""
        if (t < 45) return ""
        if (t < 60) return ""
        if (t < 75) return ""
        if (t < 85) return ""
        return ""
    }
    function tempColor(t) {
        if (t < 30) return Colors.base0D
        if (t < 70) return Colors.base0C
        if (t < 85) return Colors.base0A
        return Colors.base08
    }
    function percent(v) { return Math.round(v * 100) + "%" }

    component Value: Label {
        width: 44
        horizontalAlignment: Text.AlignLeft
    }
    component CpuStat: Row {
        spacing: 6
        CpuGraph { anchors.verticalCenter: parent.verticalCenter; history: SysStats.cpuHistory }
        Value { anchors.verticalCenter: parent.verticalCenter; text: dashboard.percent(SysStats.cpu) }
    }
    component TempStat: Row {
        spacing: 6
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: dashboard.tempIcon(SysStats.temperature)
            color: dashboard.tempColor(SysStats.temperature)
            Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
        }
        Value { anchors.verticalCenter: parent.verticalCenter; text: Math.round(SysStats.temperature) + "°" }
    }
    component GaugeStat: Row {
        id: gaugeStat
        property real value: 0
        spacing: 6
        FillSquare { anchors.verticalCenter: parent.verticalCenter; value: gaugeStat.value }
        Value { anchors.verticalCenter: parent.verticalCenter; text: dashboard.percent(gaugeStat.value) }
    }
    component Fade: Item {
        property bool active: false
        anchors.fill: parent
        opacity: active ? 1 : 0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
    }

    property string bars: ""

    Process {
        id: cava
        running: true
        command: ["cava", "-p", Quickshell.shellDir + "/cava.conf"]
        stdout: SplitParser {
            onRead: data => dashboard.bars = dashboard.render(data)
        }
        onExited: {
            dashboard.bars = ""
            cavaRestart.start()
        }
    }

    Timer {
        id: cavaRestart
        interval: 2000
        onTriggered: cava.running = true
    }

    function render(s) {
        const glyphs = "▁▂▃▄▅▆▇█"
        let out = ""
        for (const c of s) {
            const n = c.charCodeAt(0) - 48
            if (n >= 0 && n <= 7) out += glyphs[n]
        }
        return out
    }

    widgetContent: Item {
        anchors.fill: parent

        Fade {
            active: dashboard.shown === "cava"
            Label { anchors.fill: parent; text: dashboard.bars }
        }

        Fade {
            active: dashboard.shown === "stats"
            Row {
                anchors.centerIn: parent
                spacing: 20
                CpuStat {}
                TempStat {}
                GaugeStat { value: SysStats.ram }
                GaugeStat { value: SysStats.disk }
            }
        }

        Fade {
            active: dashboard.shown === "combined"
            Row {
                id: leftStats
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 14
                CpuStat {}
                TempStat {}
            }
            Row {
                id: rightStats
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 14
                GaugeStat { value: SysStats.ram }
                GaugeStat { value: SysStats.disk }
            }
            Label {
                id: squeezed
                anchors.centerIn: parent
                text: dashboard.bars
                readonly property real room: parent.width - leftStats.width - rightStats.width - 2 * 10 - 2 * 14
                transform: Scale {
                    origin.x: squeezed.width / 2
                    xScale: squeezed.implicitWidth > 0 ? Math.max(0.1, Math.min(1, squeezed.room / squeezed.implicitWidth)) : 1
                }
            }
        }
    }

    readonly property var player: {
        const ps = Mpris.players.values
        return ps.find(p => p.isPlaying) ?? (ps.length ? ps[0] : null)
    }
    readonly property string trackKey: player ? player.identity + "|" + player.trackTitle : ""
    readonly property real liveLength: {
        if (!player) return 0
        if (player.lengthSupported && player.length > 0) return player.length
        const raw = player.metadata ? player.metadata["mpris:length"] : undefined
        return raw ? raw / 1000000 : 0
    }
    property real knownLength: 0
    onLiveLengthChanged: if (liveLength > 0) knownLength = liveLength
    onTrackKeyChanged: knownLength = liveLength
    readonly property bool hasLength: knownLength > 0

    function fmt(seconds) {
        const s = Math.max(0, Math.floor(seconds))
        const h = Math.floor(s / 3600), m = Math.floor((s % 3600) / 60), r = s % 60
        const mm = h > 0 ? String(m).padStart(2, "0") : String(m)
        return (h > 0 ? h + ":" : "") + mm + ":" + String(r).padStart(2, "0")
    }

    Timer {
        interval: 1000
        repeat: true
        running: dashboard.open && dashboard.player !== null && dashboard.player.isPlaying
        onTriggered: dashboard.player.positionChanged()
    }

    Item {
        id: meta
        width: parent.width
        height: implicitHeight
        implicitHeight: metaCol.implicitHeight + 2 * 10 + Style.border

        Column {
            id: metaCol
            x: 10; y: 10
            width: parent.width - 20
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideRight
                text: dashboard.player ? dashboard.player.trackTitle : ""
            }
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideRight
                color: Colors.base03
                topPadding: 5
                text: dashboard.player ? dashboard.player.trackArtist : ""
            }
            Item { width: 1; height: 10 }
            BarButton {
                anchors.right: parent.right
                pressable: false
                anchors.rightMargin: Style.shadow
                text: dashboard.player ? (dashboard.player.desktopEntry || dashboard.player.identity.toLowerCase()) : ""
                bg: Colors.base0B
                fg: Colors.base00
                visible: dashboard.player !== null
            }
        }
        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: Style.border; color: Colors.base0E }
    }

    Item {
        id: progress
        width: parent.width
        height: visible ? implicitHeight : 0
        implicitHeight: 10 + 20 + bounds.implicitHeight + 10 + Style.border
        visible: dashboard.hasLength

        BarSlider {
            id: seek
            x: 10; y: 10
            width: parent.width - 20
            max: dashboard.knownLength
            value: dashboard.player ? dashboard.player.position : 0
            highlight: Colors.base0E
            onMoved: v => { if (dashboard.player) dashboard.player.position = v }
        }
        Item {
            id: bounds
            anchors.top: seek.bottom
            width: parent.width
            implicitHeight: 24
            Label { anchors.left: parent.left; anchors.leftMargin: 10; color: Colors.base03; text: dashboard.fmt(dashboard.player ? dashboard.player.position : 0) }
            Label { anchors.right: parent.right; anchors.rightMargin: 10; color: Colors.base03; text: dashboard.fmt(dashboard.knownLength) }
        }
        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: Style.border; color: Colors.base0E }
    }

    Item {
        id: buttons
        width: parent.width
        height: implicitHeight
        implicitHeight: row.implicitHeight + 2 * 8 + Style.shadow

        Row {
            id: row
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -Style.shadow / 2
            spacing: 10 + 2 * Style.shadow
            Repeater {
                model: [
                    { icon: "󰒮", act: () => dashboard.player.previous() },
                    { icon: "", act: () => dashboard.player.togglePlaying() },
                    { icon: "󰒭", act: () => dashboard.player.next() }
                ]
                BarButton {
                    required property var modelData
                    required property int index
                    width: 85
                    height: 70
                    text: index === 1 ? (dashboard.player && dashboard.player.isPlaying ? "󰏤" : "󰐊") : modelData.icon
                    fontSize: 42
                    bg: Colors.base0B
                    fg: Colors.base00
                    hoverBg: Colors.base0E
                    onClicked: if (dashboard.player) modelData.act()
                }
            }
        }
    }
}

import Quickshell
import Quickshell.Wayland
import QtQuick
import "../Config"
import "../Services"
import "../Widgets"

PanelWindow {
    id: win

    readonly property int hidden: Math.max(0, Notifs.popups.length - Notifs.popupLimit)
    readonly property int edge: 10
    readonly property int overshootRoom: 20
    readonly property int cardMaxWidth: 400

    readonly property int needed: stack.contentBottom
    property int shownHeight: 1
    onNeededChanged: {
        if (needed > shownHeight) { shownHeight = needed; shrink.stop() }
        else shrink.restart()
    }
    Timer {
        id: shrink
        interval: Style.closeDuration + 50
        onTriggered: win.shownHeight = Math.max(1, win.needed)
    }

    visible: Notifs.popups.length > 0
    anchors { top: true; right: true }
    margins { top: 10; right: 0 }
    exclusionMode: ExclusionMode.Normal
    exclusiveZone: 0
    implicitWidth: overshootRoom + cardMaxWidth + edge
    implicitHeight: shownHeight
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "qs-notifications"

    mask: Region {
        x: win.width - win.edge - stack.cardsWidth
        y: 0
        width: stack.cardsWidth
        height: stack.contentBottom
    }
    component SlotRegion: Region {
        required property int slot
        readonly property var c: stack.children.length > slot ? stack.children[slot] : null
        readonly property bool on: c !== null && c.visible && c.width > 0 && !(c.entry !== undefined && c.entry.closing)
        x: on ? c.x + (c.slideX !== undefined ? c.slideX : 0) : 0
        y: on ? c.y : 0
        width: on ? c.width : 0
        height: on ? c.height : 0
    }
    BackgroundEffect.blurRegion: Region {
        regions: [
            SlotRegion { slot: 0 }, SlotRegion { slot: 1 }, SlotRegion { slot: 2 }, SlotRegion { slot: 3 },
            SlotRegion { slot: 4 }, SlotRegion { slot: 5 }, SlotRegion { slot: 6 }
        ]
    }

    Column {
        id: stack
        width: win.width
        spacing: 5

        readonly property int cardsWidth: {
            let w = 0
            for (let i = 0; i < children.length; i++) {
                const c = children[i]
                if (c.visible && c.width > w) w = c.width
            }
            return w
        }
        readonly property int contentBottom: {
            let b = 0
            for (let i = 0; i < children.length; i++) {
                const c = children[i]
                if (c.visible && c.height > 0) b = Math.max(b, c.y + c.height)
            }
            return b
        }

        move: Transition {
            NumberAnimation {
                properties: "y"
                duration: Style.closeDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Style.closeCurve
            }
        }

        Repeater {
            model: ScriptModel { values: Notifs.popups.slice(0, Notifs.popupLimit) }
            NotificationCard {
                required property var modelData
                entry: modelData
                x: win.width - win.edge - width
            }
        }

        Rectangle {
            visible: win.hidden > 0
            x: win.width - win.edge - width
            width: hiddenLabel.implicitWidth + 30
            height: hiddenLabel.implicitHeight + 30
            color: Qt.alpha(Colors.base00, Style.bgAlpha)
            border.width: 5
            border.color: Colors.base05
            Text {
                id: hiddenLabel
                anchors.centerIn: parent
                font.family: "monospace"
                font.pointSize: 16
                font.bold: true
                color: Colors.base05
                text: "(" + win.hidden + " more)"
            }
        }
    }
}

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import "../Config"

PanelWindow {
    id: win

    property bool active: false
    property real blur: 0
    property real fade: 0
    readonly property string shotPath: (Quickshell.env("XDG_RUNTIME_DIR") || "/tmp") + "/qs-theme-transition.png"

    anchors { top: true; bottom: true; left: true; right: true }
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "qs-theme-transition"
    mask: Region {}
    visible: active

    Item {
        anchors.fill: parent
        opacity: win.fade

        Image {
            id: shot
            anchors.fill: parent
            cache: false
            asynchronous: true
            fillMode: Image.Stretch
            onStatusChanged: if (status === Image.Ready && win.active) { win.fade = 1; win.blur = 1 }
        }

        MultiEffect {
            anchors.fill: parent
            source: shot
            autoPaddingEnabled: false
            blurEnabled: true
            blurMax: 64
            blur: win.blur
        }
    }

    Behavior on blur {
        NumberAnimation { duration: Style.closeDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve }
    }

    Process {
        id: grab
        command: ["grim", "-l", "0", win.shotPath]
        onExited: (code, status) => {
            if (code === 0 && win.active) shot.source = "file://" + win.shotPath + "?" + Date.now()
            else win.end()
        }
    }

    function begin() {
        if (active) return
        fade = 0
        blur = 0
        shot.source = ""
        active = true
        grab.running = true
        safety.restart()
    }

    function end() {
        if (!active) return
        safety.stop()
        if (fade === 0) { active = false; return }
        fadeOut.restart()
    }

    Timer {
        id: safety
        interval: 8000
        onTriggered: win.end()
    }
    NumberAnimation {
        id: fadeOut
        target: win; property: "fade"; from: 1; to: 0
        duration: Style.closeDuration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Style.closeCurve
        onFinished: { win.active = false; win.blur = 0; shot.source = "" }
    }
}

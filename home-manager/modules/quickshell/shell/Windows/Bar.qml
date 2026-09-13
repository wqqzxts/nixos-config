import Quickshell
import Quickshell.Wayland
import QtQuick
import "../Config"
import "../Services"
import "../Modules"

PanelWindow {
    id: win

    property bool showBar: true

    function toggleThemePage() {
        if (!showBar || fullscreenHidden) show()
        controlCenter.toggleThemePage()
    }
    function openThemePage() {
        if (!showBar || fullscreenHidden) show()
        controlCenter.openThemePage()
    }
    function closeThemePage() { controlCenter.closeThemePage() }

    function cycleDashboardDisplay() { dashboard.cycleDisplay() }

    property bool peek: false
    readonly property bool fullscreenHidden: Niri.focusedFullscreen && !peek
    Connections {
        target: Niri
        function onFocusedFullscreenChanged() { if (!Niri.focusedFullscreen) win.peek = false }
    }

    function toggle() {
        if (Niri.focusedFullscreen) {
            const shown = showBar && peek
            showBar = true
            peek = !shown
        } else {
            showBar = !showBar
        }
    }
    function show() { showBar = true; if (Niri.focusedFullscreen) peek = true }
    function hide() { showBar = false; peek = false }

    property int zone: showBar && !fullscreenHidden ? Style.barHeight : 0
    Behavior on zone {
        NumberAnimation { duration: Style.animDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve }
    }
    visible: zone > 0

    anchors { top: true; left: true; right: true }
    implicitHeight: Style.barHeight + Style.menuMaxHeight
    exclusionMode: ExclusionMode.Normal
    exclusiveZone: zone
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "qs-bar"
    WlrLayershell.keyboardFocus: controlCenter.wantsKeyboard ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    component ModuleRegion: Region {
        required property Item mod
        property real rowX: 0
        x: rowX + mod.x
        y: content.y
        width: mod.width
        height: mod.height
    }
    mask: Region {
        regions: [
            ModuleRegion { mod: power; rowX: leftRow.x },
            ModuleRegion { mod: clock; rowX: leftRow.x },
            ModuleRegion { mod: weather; rowX: leftRow.x },
            ModuleRegion { mod: dashboard },
            ModuleRegion { mod: language; rowX: rightRow.x },
            ModuleRegion { mod: controlCenter; rowX: rightRow.x },
            ModuleRegion { mod: battery; rowX: rightRow.x }
        ]
    }
    BackgroundEffect.blurRegion: Region {
        regions: [
            ModuleRegion { mod: power; rowX: leftRow.x },
            ModuleRegion { mod: clock; rowX: leftRow.x },
            ModuleRegion { mod: weather; rowX: leftRow.x },
            ModuleRegion { mod: dashboard },
            ModuleRegion { mod: language; rowX: rightRow.x },
            ModuleRegion { mod: controlCenter; rowX: rightRow.x },
            ModuleRegion { mod: battery; rowX: rightRow.x }
        ]
    }

    Item {
        id: content
        anchors { left: parent.left; right: parent.right }
        height: Style.barHeight
        y: win.zone - Style.barHeight
        opacity: win.zone / Style.barHeight

        Row {
            id: leftRow
            anchors.left: parent.left
            anchors.leftMargin: Style.shadow
            spacing: Style.spacing + 2 * Style.shadow
            PowerModule { id: power }
            ClockModule { id: clock }
            WeatherModule { id: weather }
        }

        DashboardModule {
            id: dashboard
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row {
            id: rightRow
            anchors.right: parent.right
            anchors.rightMargin: Style.shadow
            spacing: Style.spacing + 2 * Style.shadow
            LanguageModule { id: language }
            ControlCenterModule {
                id: controlCenter
                onHideRequested: win.hide()
            }
            BatteryModule { id: battery }
        }
    }
}

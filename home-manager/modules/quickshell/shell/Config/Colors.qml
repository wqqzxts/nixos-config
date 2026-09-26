pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: colors

    property string style: "gruvbox"
    property string polarity: "dark"
    property var styles: ["gruvbox"]

    property color base00: "#292828"
    property color base01: "#32302f"
    property color base02: "#504945"
    property color base03: "#665c54"
    property color base04: "#bdae93"
    property color base05: "#ddc7a1"
    property color base06: "#ebdbb2"
    property color base07: "#fbf1c7"
    property color base08: "#ea6962"
    property color base09: "#e78a4e"
    property color base0A: "#d8a657"
    property color base0B: "#a9b665"
    property color base0C: "#89b482"
    property color base0D: "#7daea3"
    property color base0E: "#d3869b"
    property color base0F: "#bd6f3e"

    Behavior on base00 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base01 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base02 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base03 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base04 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base05 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base06 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base07 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base08 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base09 { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base0A { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base0B { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base0C { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base0D { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base0E { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }
    Behavior on base0F { ColorAnimation { duration: 375; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.85, 0, 0.25, 1, 1, 1] } }

    readonly property string themeFile: Quickshell.env("QS_THEME_FILE") || (Quickshell.env("HOME") + "/.config/quickshell/theme.json")

    FileView {
        id: file
        path: colors.themeFile
        printErrors: false
        watchChanges: true
        onFileChanged: reload()
        onLoaded: colors.apply(text())
    }

    function reload() { file.reload() }
    function ledge(c) { return Qt.darker(c, Style.ledgeDarken) }

    function apply(json) {
        let t
        try { t = JSON.parse(json) } catch (e) { console.warn("theme.json unreadable:", e); return }
        if (t.style) style = t.style
        if (t.polarity) polarity = t.polarity
        if (Array.isArray(t.styles) && JSON.stringify(t.styles) !== JSON.stringify(styles)) styles = t.styles
        for (const k in (t.colors || {})) {
            if (k in colors && /^base0[0-9A-F]$/.test(k)) colors[k] = t.colors[k]
        }
    }
}

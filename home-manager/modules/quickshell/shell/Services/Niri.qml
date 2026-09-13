pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: niri

    property var keyboardNames: []
    property int keyboardIndex: 0

    property var windowSizes: ({})
    property var focusedId: null

    readonly property bool focusedFullscreen: {
        const s = focusedId !== null ? windowSizes[focusedId] : undefined
        if (!s) return false
        const screens = Quickshell.screens
        for (let i = 0; i < screens.length; i++) {
            if (screens[i].width === s[0] && screens[i].height === s[1]) return true
        }
        return false
    }

    Process {
        id: stream
        running: true
        command: ["niri", "msg", "-j", "event-stream"]
        stdout: SplitParser {
            onRead: data => niri.handle(data)
        }
        onExited: reconnect.start()
    }
    Timer {
        id: reconnect
        interval: 2000
        onTriggered: stream.running = true
    }

    function setSize(sizes, id, size) {
        const cur = sizes[id]
        if (cur && cur[0] === size[0] && cur[1] === size[1]) return false
        sizes[id] = [size[0], size[1]]
        return true
    }

    function handle(line) {
        let e
        try { e = JSON.parse(line) } catch (err) { return }

        if (e.KeyboardLayoutsChanged) {
            keyboardNames = e.KeyboardLayoutsChanged.keyboard_layouts.names
            keyboardIndex = e.KeyboardLayoutsChanged.keyboard_layouts.current_idx
        } else if (e.KeyboardLayoutSwitched) {
            keyboardIndex = e.KeyboardLayoutSwitched.idx
        } else if (e.WindowsChanged) {
            const sizes = {}
            let focused = null
            for (const w of e.WindowsChanged.windows) {
                sizes[w.id] = w.layout.window_size
                if (w.is_focused) focused = w.id
            }
            windowSizes = sizes
            focusedId = focused
        } else if (e.WindowOpenedOrChanged) {
            const w = e.WindowOpenedOrChanged.window
            const sizes = Object.assign({}, windowSizes)
            if (setSize(sizes, w.id, w.layout.window_size)) windowSizes = sizes
            if (w.is_focused) focusedId = w.id
        } else if (e.WindowLayoutsChanged) {
            const sizes = Object.assign({}, windowSizes)
            let changed = false
            for (const c of e.WindowLayoutsChanged.changes) {
                if (setSize(sizes, c[0], c[1].window_size)) changed = true
            }
            if (changed) windowSizes = sizes
        } else if (e.WindowClosed) {
            const sizes = Object.assign({}, windowSizes)
            delete sizes[e.WindowClosed.id]
            windowSizes = sizes
            if (focusedId === e.WindowClosed.id) focusedId = null
        } else if (e.WindowFocusChanged) {
            focusedId = e.WindowFocusChanged.id
        }
    }
}

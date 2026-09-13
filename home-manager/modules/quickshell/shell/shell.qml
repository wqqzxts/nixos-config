import Quickshell
import Quickshell.Io
import QtQuick
import "Config"
import "Windows"

ShellRoot {
    Bar { id: bar }
    NotificationPopups {}
    ThemeTransition { id: transition }

    IpcHandler {
        target: "theme"
        function reload(): void { Colors.reload() }
        function toggle(): void { bar.toggleThemePage() }
        function open(): void { bar.openThemePage() }
        function close(): void { bar.closeThemePage() }
    }

    IpcHandler {
        target: "dashboard"
        function cycle(): void { bar.cycleDashboardDisplay() }
    }

    IpcHandler {
        target: "transition"
        function begin(): void { transition.begin() }
        function end(): void { transition.end() }
    }

    IpcHandler {
        target: "bar"
        function toggle(): void { bar.toggle() }
        function open(): void { bar.show() }
        function close(): void { bar.hide() }
    }
}

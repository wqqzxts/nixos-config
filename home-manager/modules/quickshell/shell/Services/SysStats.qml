pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: stats

    property real cpu: 0
    property var cpuHistory: [0, 0, 0, 0, 0, 0, 0, 0]
    property real temperature: 0
    property real ram: 0
    property real disk: 0

    property real lastIdle: 0
    property real lastTotal: 0

    property string tempPath: ""
    Process {
        running: true
        command: ["sh", "-c",
            "for h in /sys/class/hwmon/hwmon*; do case \"$(cat \"$h/name\" 2>/dev/null)\" in "
            + "k10temp|coretemp|zenpower|cpu_thermal) echo \"$h/temp1_input\"; exit ;; esac; done; "
            + "echo /sys/class/thermal/thermal_zone0/temp"]
        stdout: StdioCollector { onStreamFinished: stats.tempPath = text.trim() }
    }

    FileView {
        id: procStat
        path: "/proc/stat"
        printErrors: false
        onLoaded: {
            const f = text().split("\n")[0].trim().split(/\s+/).slice(1, 9).map(Number)
            const idle = f[3] + f[4]
            const total = f.reduce((a, b) => a + b, 0)
            if (stats.lastTotal > 0 && total > stats.lastTotal) {
                stats.cpu = Math.max(0, Math.min(1, 1 - (idle - stats.lastIdle) / (total - stats.lastTotal)))
                stats.cpuHistory = stats.cpuHistory.slice(1).concat([stats.cpu])
            }
            stats.lastIdle = idle
            stats.lastTotal = total
        }
    }

    FileView {
        id: memInfo
        path: "/proc/meminfo"
        printErrors: false
        onLoaded: {
            const t = text()
            const total = parseInt((t.match(/^MemTotal:\s+(\d+)/m) || [])[1])
            const available = parseInt((t.match(/^MemAvailable:\s+(\d+)/m) || [])[1])
            if (total > 0 && available >= 0) stats.ram = 1 - available / total
        }
    }

    FileView {
        id: tempFile
        path: stats.tempPath
        printErrors: false
        onLoaded: {
            const milli = parseInt(text())
            if (!isNaN(milli)) stats.temperature = milli / 1000
        }
    }

    Process {
        id: df
        command: ["df", "--output=pcent", "/"]
        stdout: StdioCollector {
            onStreamFinished: {
                const m = text.match(/(\d+)%/)
                if (m) stats.disk = parseInt(m[1]) / 100
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            procStat.reload()
            memInfo.reload()
            if (stats.tempPath !== "") tempFile.reload()
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: df.running = true
    }
}

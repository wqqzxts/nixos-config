import Quickshell
import Quickshell.Io
import QtQuick
import "../Config"
import "../Widgets"

BarModule {
    id: weather
    widgetWidth: 85
    borderColor: Colors.base0A
    menuBorder: false
    menuGap: Style.spacing
    menuSpacing: Style.spacing

    property string temp: ""
    property string ftemp: ""
    property string condition: ""
    property string wind: ""
    property string uv: ""

    Process {
        id: fetch
        command: ["curl", "-s", "wttr.in/Tashkent?m&format=%t+%f+%C+%w+%u"]
        stdout: StdioCollector {
            onStreamFinished: weather.parse(text)
        }
    }
    Timer {
        interval: 600000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetch.running = true
    }

    function parse(s) {
        const f = s.trim().split(/\s+/)
        if (f.length < 5) return
        temp = f[0].replace("°C", "")
        ftemp = f[1].replace("°C", "")
        condition = f.slice(2, f.length - 2).join(" ")
        const kmh = parseFloat(f[f.length - 2].replace(/[^0-9.]/g, "")) || 0
        wind = (kmh / 3.6).toFixed(1)
        uv = f[f.length - 1]
    }

    function icon(c) {
        switch (c) {
        case "Clear": case "Sunny": return "󰖙"
        case "Partly cloudy": return "󰖕"
        case "Cloudy": case "Overcast": return "󰖐"
        case "Mist": case "Fog": case "Freezing fog": return "󰖑"
        case "Blowing snow": case "Blizzard": case "Heavy snow": return "󰼶"
        case "Light snow": case "Moderate snow": return "󰖘"
        case "Light rain": case "Moderate rain": case "Heavy rain":
        case "Light sleet": case "Moderate or heavy sleet": return "󰖗"
        default: return ""
        }
    }

    widgetContent: Label {
        anchors.fill: parent
        text: weather.icon(weather.condition) + " " + weather.temp
    }

    Repeater {
        model: [
            { icon: "󰙍", value: weather.ftemp },
            { icon: "󱪈", value: weather.wind },
            { icon: "󱁝 ", value: weather.uv }
        ]
        BarButton {
            required property var modelData
            required property int index
            width: 85
            text: modelData.icon + " " + modelData.value
            bg: Colors.base00
            borderColor: Colors.base0A
        }
    }
}

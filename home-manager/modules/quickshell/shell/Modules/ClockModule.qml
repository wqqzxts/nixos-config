import Quickshell
import QtQuick
import "../Config"
import "../Widgets"

BarModule {
    id: clock
    widgetWidth: 430
    menuPadding: 5

    SystemClock {
        id: sysClock
        precision: SystemClock.Minutes
    }

    widgetContent: Label {
        anchors.fill: parent
        text: Qt.formatDateTime(sysClock.date, "dddd | MMMM dd | hh:mm AP")
    }

    readonly property int cellWidth: Math.floor(innerWidth / 7)
    readonly property int cellHeight: 28
    readonly property date today: sysClock.date
    readonly property date firstOfMonth: new Date(today.getFullYear(), today.getMonth(), 1)

    function cellDate(index) {
        return new Date(today.getFullYear(), today.getMonth(), 1 - firstOfMonth.getDay() + index)
    }

    Row {
        Repeater {
            model: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            Label {
                required property string modelData
                width: clock.cellWidth
                height: clock.cellHeight
                text: modelData
            }
        }
    }

    Grid {
        columns: 7
        Repeater {
            model: 42
            Rectangle {
                required property int index
                readonly property date d: clock.cellDate(index)
                readonly property bool isToday: d.getDate() === clock.today.getDate() && d.getMonth() === clock.today.getMonth()
                width: clock.cellWidth
                height: clock.cellHeight
                color: isToday ? Colors.base05 : "transparent"
                Label {
                    anchors.fill: parent
                    text: d.getDate()
                    color: isToday ? Colors.base00 : (d.getMonth() === clock.today.getMonth() ? Colors.base05 : Colors.base03)
                }
            }
        }
    }
}

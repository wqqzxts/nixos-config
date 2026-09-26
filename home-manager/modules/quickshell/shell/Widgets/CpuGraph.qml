import QtQuick
import "../Config"

Item {
    id: graph

    property var history: []
    property int size: 18
    property int barWidth: 3
    property int gap: 1

    implicitWidth: Math.max(0, history.length * (barWidth + gap) - gap)
    implicitHeight: size

    Repeater {
        model: graph.history.length
        Rectangle {
            required property int index
            readonly property real load: Math.max(0, Math.min(1, graph.history[index] || 0))
            x: index * (graph.barWidth + graph.gap)
            width: graph.barWidth
            height: Math.max(2, Math.round(graph.size * load))
            y: graph.size - height
            color: load >= 0.9 ? Colors.base08 : (load >= 0.7 ? Colors.base0A : Colors.base05)
            Behavior on height { NumberAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
            Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
        }
    }
}

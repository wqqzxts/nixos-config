import QtQuick
import "../Config"

Item {
    id: gauge

    property real value: 0
    property int size: 18
    property int stroke: 2
    readonly property int inner: size - 2 * (stroke + 1)
    readonly property color fillColor: value >= 0.9 ? Colors.base08 : (value >= 0.75 ? Colors.base0A : Colors.base0C)

    implicitWidth: size
    implicitHeight: size

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: gauge.stroke
        border.color: Colors.base05
    }

    Rectangle {
        x: gauge.stroke + 1
        width: gauge.inner
        height: Math.round(gauge.inner * Math.max(0, Math.min(1, gauge.value)))
        y: gauge.size - gauge.stroke - 1 - height
        color: gauge.fillColor
        Behavior on height { NumberAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
        Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
    }
}

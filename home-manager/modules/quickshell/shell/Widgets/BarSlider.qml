import QtQuick
import "../Config"

Item {
    id: slider

    property real value: 0
    property real max: 100
    property bool active: true
    property color highlight: Colors.base04
    property color trough: Colors.base02
    property color handle: Colors.base05
    signal moved(real value)

    readonly property real fraction: max > 0 ? Math.max(0, Math.min(1, value / max)) : 0
    implicitHeight: 20

    property real sink: active && mouse.pressed ? 1 : 0
    Behavior on sink { NumberAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }

    Item {
        id: line
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 10

        Rectangle {
            width: parent.width
            height: parent.height
            color: slider.trough
        }
        Rectangle {
            y: parent.height
            width: parent.width
            height: Style.shadow
            color: Colors.ledge(slider.trough)
        }
        Rectangle {
            width: fill.width
            height: parent.height
            color: slider.highlight
        }
        Rectangle {
            id: fill
            y: parent.height
            width: slider.fraction * parent.width
            height: Style.shadow
            color: Colors.ledge(slider.highlight)
        }
    }

    Item {
        id: knob
        x: slider.fraction * (parent.width - width - Style.shadow)
        width: 5
        height: 20

        Rectangle {
            id: knobFace
            y: Style.shadow * slider.sink
            width: parent.width
            height: parent.height
            color: slider.handle
        }
        Rectangle {
            x: parent.width
            y: knobFace.y
            width: Style.shadow * (1 - slider.sink)
            height: parent.height + Style.shadow - knobFace.y
            color: Colors.ledge(slider.handle)
        }
        Rectangle {
            y: knobFace.y + parent.height
            width: parent.width
            height: Style.shadow - knobFace.y
            color: Colors.ledge(slider.handle)
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        enabled: slider.active
        cursorShape: Qt.PointingHandCursor
        function emit(mx) { slider.moved(Math.max(0, Math.min(1, mx / width)) * slider.max) }
        onPressed: mouse => emit(mouse.x)
        onPositionChanged: mouse => { if (pressed) emit(mouse.x) }
    }
}

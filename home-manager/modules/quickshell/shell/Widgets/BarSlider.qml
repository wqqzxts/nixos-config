import QtQuick
import "../Config"

Item {
    id: slider

    property real value: 0
    property real max: 100
    property bool active: true
    property color highlight: Colors.base0C
    property color trough: Colors.base03
    property color handle: Colors.base0B
    signal moved(real value)

    readonly property real fraction: max > 0 ? Math.max(0, Math.min(1, value / max)) : 0
    implicitHeight: 20

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 10
        color: slider.trough
    }
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: slider.fraction * parent.width
        height: 10
        color: slider.highlight
    }
    Rectangle {
        x: slider.fraction * (parent.width - width)
        width: 5
        height: 20
        color: slider.handle
    }

    MouseArea {
        anchors.fill: parent
        enabled: slider.active
        cursorShape: Qt.PointingHandCursor
        function emit(mx) { slider.moved(Math.max(0, Math.min(1, mx / width)) * slider.max) }
        onPressed: mouse => emit(mouse.x)
        onPositionChanged: mouse => { if (pressed) emit(mouse.x) }
    }
}

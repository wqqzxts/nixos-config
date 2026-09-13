import QtQuick
import "../Config"

Item {
    id: btn

    property string text
    property bool active: false
    property bool bordered: borderColor.a > 0
    property bool pressable: true
    property int depth: Style.shadow
    property color fg: Colors.base05
    property color bg: "transparent"
    property color borderColor: "transparent"
    property color hoverBg: active ? activeBg : bg
    property color hoverFg: active ? activeFg : fg
    property color activeBg: bg
    property color activeFg: fg
    property color activeBorder: borderColor
    property real fontSize: Style.fontSize
    property int hPadding: 10
    property int vPadding: 5
    property int textAlign: Text.AlignHCenter
    signal clicked()

    readonly property int borderWidth: bordered ? Style.border : 0
    implicitWidth: label.implicitWidth + 2 * (hPadding + borderWidth)
    implicitHeight: label.implicitHeight + 2 * (vPadding + borderWidth)

    property real sink: pressable && mouse.pressed ? 1 : 0
    property real rise: pressable && mouse.containsMouse && !mouse.pressed ? 1 : 0
    Behavior on sink { NumberAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
    Behavior on rise { NumberAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }

    Ledge {
        y: face.y
        width: btn.width
        height: btn.height
        side: btn.depth * (1 - btn.sink)
        drop: btn.depth - face.y
        color: Colors.ledge(btn.bordered ? face.border.color : face.color)
    }

    Rectangle {
        id: face
        y: btn.depth * btn.sink - Style.keyLift * btn.rise
        width: btn.width
        height: btn.height
        color: mouse.containsMouse ? btn.hoverBg : (btn.active ? btn.activeBg : btn.bg)
        border.width: btn.borderWidth
        border.color: btn.active ? btn.activeBorder : btn.borderColor
        Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
        Behavior on border.color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }

        Label {
            id: label
            anchors.fill: parent
            anchors.leftMargin: btn.hPadding + btn.borderWidth
            anchors.rightMargin: btn.hPadding + btn.borderWidth
            text: btn.text
            font.pointSize: btn.fontSize
            horizontalAlignment: btn.textAlign
            color: mouse.containsMouse ? btn.hoverFg : (btn.active ? btn.activeFg : btn.fg)
            Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: btn.clicked()
    }
}

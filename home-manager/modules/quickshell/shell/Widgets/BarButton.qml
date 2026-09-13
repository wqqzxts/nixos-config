import QtQuick
import "../Config"

Rectangle {
    id: btn

    property string text
    property bool active: false
    property bool bordered: borderColor.a > 0
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

    implicitWidth: label.implicitWidth + 2 * (hPadding + border.width)
    implicitHeight: label.implicitHeight + 2 * (vPadding + border.width)
    color: mouse.containsMouse ? hoverBg : (active ? activeBg : bg)
    border.width: bordered ? Style.border : 0
    border.color: active ? activeBorder : borderColor
    Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
    Behavior on border.color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }

    Label {
        id: label
        anchors.fill: parent
        anchors.leftMargin: btn.hPadding + btn.border.width
        anchors.rightMargin: btn.hPadding + btn.border.width
        text: btn.text
        font.pointSize: btn.fontSize
        horizontalAlignment: btn.textAlign
        color: mouse.containsMouse ? btn.hoverFg : (btn.active ? btn.activeFg : btn.fg)
        Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: btn.clicked()
    }
}

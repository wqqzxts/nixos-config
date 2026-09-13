import Quickshell
import Quickshell.Widgets
import QtQuick
import "../Config"
import "../Services"
import "spring.js" as Spring

Rectangle {
    id: card

    required property NotifEntry entry
    readonly property int frame: 5
    readonly property int pad: 10
    readonly property int minWidth: 200
    readonly property int maxWidth: 400
    readonly property bool hasIcon: entry.icon !== ""
    readonly property int iconSpan: hasIcon ? 64 + pad : 0
    readonly property int maxTextWidth: maxWidth - 2 * (frame + pad) - iconSpan

    color: Qt.alpha(Colors.base00, Style.bgAlpha)
    border.width: frame
    border.color: Notifs.frameColor(entry.urgency)
    width: Math.max(minWidth, Math.min(maxWidth, textCol.implicitWidth + iconSpan + 2 * (frame + pad)))
    height: Math.max(hasIcon ? 64 : 0, textCol.implicitHeight) + 2 * (frame + pad)

    readonly property var spring: Spring.make(Style.springStiffness, Style.springDamping, Style.springEpsilon)
    property real openT: 0
    property real closeT: 0
    readonly property real openV: Spring.at(spring, openT)

    readonly property real slideX: entry.closing ? 0 : (1 - openV) * (width + 10)
    transform: Translate { x: card.slideX }
    layer.enabled: true
    opacity: entry.closing ? 1 - closeT : 1

    NumberAnimation on openT {
        from: 0; to: card.spring.duration
        duration: card.spring.duration
    }
    NumberAnimation {
        id: closeAnim
        target: card; property: "closeT"
        from: 0; to: 1
        duration: Style.closeDuration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Style.closeCurve
        onFinished: Notifs.finishHide(card.entry)
    }
    Connections {
        target: card.entry
        function onClosingChanged() { if (card.entry.closing) closeAnim.start() }
    }
    Component.onCompleted: if (entry.closing) closeAnim.start()

    IconImage {
        x: card.frame + card.pad
        y: card.frame + card.pad
        implicitSize: 64
        visible: card.hasIcon
        source: card.entry.icon
    }

    Column {
        id: textCol
        x: card.frame + card.pad + card.iconSpan
        y: card.frame + card.pad
        width: Math.min(implicitWidth, card.maxTextWidth)

        Text {
            width: Math.min(implicitWidth, card.maxTextWidth)
            font.family: "monospace"
            font.pointSize: 22
            font.bold: true
            color: Colors.base05
            wrapMode: Text.Wrap
            text: (card.entry.count > 1 ? "(" + card.entry.count + ") " : "") + card.entry.summary
        }
        Text {
            width: Math.min(implicitWidth, card.maxTextWidth)
            visible: card.entry.body !== ""
            font.family: "monospace"
            font.pointSize: 16
            color: Colors.base05
            wrapMode: Text.Wrap
            textFormat: Text.StyledText
            maximumLineCount: 8
            elide: Text.ElideRight
            text: card.entry.body
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: !card.entry.closing
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) Notifs.activate(card.entry)
            else if (mouse.button === Qt.MiddleButton) Notifs.dismissPopups()
            else Notifs.dismiss(card.entry)
        }
    }

    Timer {
        interval: card.entry.deadline > 0 ? Math.max(1, card.entry.deadline - Date.now()) : 0
        running: card.entry.deadline > 0 && !card.entry.closing
        onTriggered: Notifs.hidePopup(card.entry)
    }
}

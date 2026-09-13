import QtQuick
import "../Config"

Item {
    id: mod

    property int widgetWidth: 55
    property color background: Colors.base00
    property color foreground: Colors.base05
    property color borderColor: Colors.base05
    property bool menuBorder: true
    property color menuBackground: menuBorder ? Colors.base00 : "transparent"
    property int menuPadding: 0
    property int menuGap: 0
    property int menuSpacing: 0
    property bool hovered: false
    property bool pinned: false
    property bool open: hovered || pinned
    signal closed()
    property real progress: open ? 1 : 0
    Behavior on progress {
        NumberAnimation { duration: Style.animDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve }
    }
    onProgressChanged: if (progress === 0 && !open) closed()
    property alias widgetContent: widgetInner.data
    default property alias menuContent: menuColumn.data

    readonly property int menuSide: menuBorder ? Style.border : 0
    readonly property int innerWidth: widgetWidth - 2 * (menuSide + menuPadding)

    width: widgetWidth
    height: widgetBox.height + menuClip.height

    HoverHandler {
        onHoveredChanged: mod.hovered = hovered
    }

    Rectangle {
        id: widgetBox
        width: mod.widgetWidth
        height: Style.barHeight - Style.barPadding
        color: Qt.alpha(mod.background, Style.bgAlpha)
        border.width: Style.border
        border.color: mod.borderColor

        Item {
            id: widgetInner
            anchors.fill: parent
            anchors.margins: Style.border
        }
    }

    Item {
        id: menuClip
        clip: true
        y: widgetBox.height
        width: mod.widgetWidth
        height: Math.round(mod.progress * menuBox.height)

        Rectangle {
            id: menuBox
            anchors.bottom: parent.bottom
            width: parent.width
            clip: true
            height: menuColumn.height + mod.menuSide + 2 * mod.menuPadding + mod.menuGap
            Behavior on height {
                NumberAnimation { duration: Style.animDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve }
            }
            color: Qt.alpha(mod.menuBackground, Style.bgAlpha)

            Rectangle { width: mod.menuSide; height: parent.height; color: mod.borderColor }
            Rectangle { x: parent.width - mod.menuSide; width: mod.menuSide; height: parent.height; color: mod.borderColor }
            Rectangle { y: parent.height - mod.menuSide; width: parent.width; height: mod.menuSide; color: mod.borderColor }

            Column {
                id: menuColumn
                x: mod.menuSide + mod.menuPadding
                y: mod.menuGap + mod.menuPadding
                width: mod.innerWidth
                spacing: mod.menuSpacing
                move: Transition {
                    NumberAnimation { properties: "y"; duration: Style.animDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve }
                }
            }
        }
    }
}

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
    readonly property real menuBleed: menuBorder ? 0 : Style.shadow
    readonly property int innerWidth: widgetWidth - 2 * (menuSide + menuPadding)

    width: widgetWidth
    height: widgetBox.height + menuClip.height

    HoverHandler {
        onHoveredChanged: mod.hovered = hovered
    }

    Ledge {
        width: mod.widgetWidth
        height: widgetBox.height + (mod.menuBorder ? menuClip.height : 0)
        color: Colors.ledge(mod.borderColor)
    }

    Rectangle {
        id: widgetBox
        width: mod.widgetWidth
        height: Style.barHeight - Style.barPadding - Style.shadow
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
        x: -mod.menuBleed
        y: widgetBox.height
        width: mod.widgetWidth + 2 * mod.menuBleed
        height: Math.round(mod.progress * menuBox.height)

        Rectangle {
            id: menuBox
            anchors.bottom: parent.bottom
            width: parent.width
            clip: true
            height: menuColumn.height + mod.menuSide + 2 * mod.menuPadding + mod.menuGap + mod.menuBleed
            Behavior on height {
                NumberAnimation { duration: Style.animDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve }
            }
            color: Qt.alpha(mod.menuBackground, Style.bgAlpha)

            Rectangle { width: mod.menuSide; height: parent.height; color: mod.borderColor }
            Rectangle { x: parent.width - mod.menuSide; width: mod.menuSide; height: parent.height; color: mod.borderColor }
            Rectangle { y: parent.height - mod.menuSide; width: parent.width; height: mod.menuSide; color: mod.borderColor }

            Column {
                id: menuColumn
                x: mod.menuBleed + mod.menuSide + mod.menuPadding
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

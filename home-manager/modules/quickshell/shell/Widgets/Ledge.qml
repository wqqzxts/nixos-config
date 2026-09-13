import QtQuick
import "../Config"

Item {
    id: ledge

    property real side: Style.shadow
    property real drop: Style.shadow
    required property color color

    Rectangle { x: -ledge.side; width: ledge.side; height: ledge.height + ledge.drop; color: ledge.color }
    Rectangle { x: ledge.width; width: ledge.side; height: ledge.height + ledge.drop; color: ledge.color }
    Rectangle { x: -ledge.side; y: ledge.height; width: ledge.width + 2 * ledge.side; height: ledge.drop; color: ledge.color }
}

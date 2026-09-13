import QtQuick
import "../Config"

Rectangle {
    id: row

    property string icon
    property string title
    property string detail
    property bool highlighted: false
    signal clicked()
    signal rightClicked()

    implicitHeight: 36
    color: mouse.containsMouse ? Colors.base02 : (highlighted ? Colors.base01 : "transparent")
    Behavior on color { ColorAnimation { duration: Style.colorDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Style.closeCurve } }

    Rectangle {
        visible: row.highlighted
        width: Style.border
        height: parent.height
        color: Colors.base0B
    }

    Label {
        id: iconLabel
        x: Style.border + 8
        width: 28
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
        text: row.icon
    }

    Label {
        id: detailLabel
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        font.bold: false
        color: Colors.base04
        text: row.detail
    }

    Label {
        anchors.left: iconLabel.right
        anchors.leftMargin: 6
        anchors.right: detailLabel.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
        elide: Text.ElideRight
        text: row.title
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: m => m.button === Qt.RightButton ? row.rightClicked() : row.clicked()
    }
}

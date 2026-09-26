import Quickshell
import QtQuick
import "../../Config"
import "../../Widgets"

Item {
    id: page

    required property var item
    signal backRequested()

    readonly property int rowHeight: 36
    readonly property int visibleRows: 8

    property var stack: []
    property var handle: item ? item.menu : null

    width: parent ? parent.width : 0
    height: column.implicitHeight

    onItemChanged: {
        stack = []
        handle = item ? item.menu : null
    }

    function enter(entry) {
        stack = stack.concat([handle])
        handle = entry
    }
    function leave() {
        if (stack.length === 0) {
            backRequested()
            return
        }
        handle = stack[stack.length - 1]
        stack = stack.slice(0, -1)
    }

    QsMenuOpener {
        id: opener
        menu: page.handle
    }

    readonly property var entries: opener.children.values.filter(e => !e.isSeparator)

    function mark(entry) {
        if (entry.buttonType === QsMenuButtonType.CheckBox)
            return entry.checkState === Qt.Checked ? "󰄲" : "󰄱"
        if (entry.buttonType === QsMenuButtonType.RadioButton)
            return entry.checkState === Qt.Checked ? "󰐾" : "󰄰"
        return entry.hasChildren ? "󰍝" : ""
    }

    Column {
        id: column
        width: parent.width

        Rectangle { width: parent.width; height: Style.border; color: Colors.base05 }

        Item {
            width: parent.width
            height: 50

            BarButton {
                id: back
                x: 10 + Style.shadow
                width: 40
                hPadding: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Style.shadow / 2
                text: "󰁍"
                bg: Colors.base02
                hoverBg: active ? Colors.base04 : Colors.base03
                hoverFg: active ? Colors.base00 : Colors.base05
                onClicked: page.leave()
            }
            Label {
                anchors.left: back.right
                anchors.leftMargin: 10 + Style.shadow
                anchors.right: parent.right
                anchors.rightMargin: 10 + Style.shadow
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Style.shadow / 2
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideRight
                text: page.item ? (page.item.title || page.item.id) : ""
            }
        }

        Label {
            visible: page.entries.length === 0
            width: parent.width
            height: visible ? 40 : 0
            font.bold: false
            color: Colors.base04
            text: "no menu entries"
        }

        ListView {
            id: list
            visible: page.entries.length > 0
            width: parent.width
            height: visible ? Math.min(contentHeight, page.visibleRows * page.rowHeight) : 0
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model: page.entries
            delegate: ListRow {
                required property var modelData
                width: list.width
                icon: page.mark(modelData)
                title: modelData.text
                opacity: modelData.enabled ? 1 : 0.5
                onClicked: {
                    if (modelData.hasChildren) {
                        page.enter(modelData)
                    } else if (modelData.enabled) {
                        modelData.triggered()
                        page.backRequested()
                    }
                }
            }
        }

        Rectangle { width: parent.width; height: 10; color: "transparent" }
    }
}

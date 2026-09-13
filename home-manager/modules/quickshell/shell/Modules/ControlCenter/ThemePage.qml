import Quickshell
import QtQuick
import "../../Config"
import "../../Widgets"

Item {
    id: page

    signal backRequested()

    readonly property int rowHeight: 36
    readonly property int visibleRows: 6
    readonly property bool dark: Colors.polarity === "dark"

    width: parent ? parent.width : 0
    height: column.implicitHeight

    function set(style, polarity) {
        Quickshell.execDetached(["theme", "set", style, polarity])
    }

    Column {
        id: column
        width: parent.width

        Rectangle { width: parent.width; height: Style.border; color: Colors.base0C }

        Item {
            width: parent.width
            height: 50

            BarButton {
                id: back
                x: 10
                width: 40
                hPadding: 0
                anchors.verticalCenter: parent.verticalCenter
                text: "󰁍"
                bg: Colors.base03
                hoverBg: Colors.base0C
                hoverFg: Colors.base00
                onClicked: page.backRequested()
            }
            Label {
                anchors.left: back.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: "Theme"
            }
            BarButton {
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 100
                text: page.dark ? "󰖔 dark" : "󰖨 light"
                bg: Colors.base03
                hoverBg: Colors.base0C
                hoverFg: Colors.base00
                onClicked: page.set(Colors.style, page.dark ? "light" : "dark")
            }
        }

        ListView {
            id: list
            width: parent.width
            height: Math.min(contentHeight, page.visibleRows * page.rowHeight)
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model: Colors.styles

            delegate: ListRow {
                required property string modelData
                width: list.width
                implicitHeight: page.rowHeight
                icon: "󰏘"
                title: modelData
                detail: modelData === Colors.style ? "active" : ""
                highlighted: modelData === Colors.style
                onClicked: if (modelData !== Colors.style) page.set(modelData, Colors.polarity)
            }
        }

        Item { width: 1; height: 10 }
    }
}

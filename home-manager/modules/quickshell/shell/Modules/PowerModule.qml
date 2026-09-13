import Quickshell
import QtQuick
import "../Config"
import "../Widgets"

BarModule {
    widgetWidth: 55
    background: Colors.base08
    borderColor: Colors.redDark
    menuBorder: false
    menuGap: Style.spacing + Style.shadow
    menuSpacing: Style.spacing + Style.shadow

    widgetContent: Label {
        anchors.fill: parent
        font.pointSize: Style.fontSize * 1.25
        text: ""
        color: Colors.base00
    }

    Repeater {
        model: [
            { icon: "󰤁", cmd: ["systemctl", "poweroff"] },
            { icon: "󰜉", cmd: ["systemctl", "reboot"] },
            { icon: "󰤄", cmd: ["systemctl", "suspend"] },
            { icon: "󰌾", cmd: ["loginctl", "lock-session"] }
        ]
        BarButton {
            required property var modelData
            required property int index
            width: 55
            text: modelData.icon
            bg: Colors.base00
            borderColor: Colors.redDark
            hoverBg: Colors.base08
            hoverFg: Colors.base00
            onClicked: Quickshell.execDetached(modelData.cmd)
        }
    }
}

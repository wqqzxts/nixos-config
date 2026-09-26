import Quickshell
import QtQuick
import "../Config"
import "../Widgets"

BarModule {
    widgetWidth: 55
    menuBorder: false
    menuGap: Style.spacing + Style.shadow
    menuSpacing: Style.spacing + Style.shadow

    widgetContent: Label {
        anchors.fill: parent
        font.pointSize: Style.fontSize * 1.25
        text: ""
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
            borderColor: Colors.base05
            hoverBg: active ? Colors.base04 : Colors.base02
            hoverFg: active ? Colors.base00 : Colors.base05
            onClicked: Quickshell.execDetached(modelData.cmd)
        }
    }
}

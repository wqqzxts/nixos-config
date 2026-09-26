import Quickshell
import Quickshell.Services.UPower
import QtQuick
import "../Config"
import "../Widgets"

BarModule {
    id: battery
    widgetWidth: 55
    menuBorder: false
    menuGap: Style.spacing + Style.shadow
    menuSpacing: Style.spacing + Style.shadow

    readonly property var device: UPower.displayDevice
    readonly property int capacity: device ? Math.round(device.percentage * 100) : 0
    readonly property bool charging: device ? device.state === UPowerDeviceState.Charging : false

    function icon() {
        if (capacity > 99) return charging ? "󰂅" : "󰁹"
        const i = Math.floor(capacity / 10)
        if (charging) return capacity > 1
            ? ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋"][i]
            : "󰂎"
        return ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂"][i]
    }

    widgetContent: Label {
        anchors.fill: parent
        text: battery.icon()
    }

    Repeater {
        model: [
            { icon: "󰓅", profile: PowerProfile.Performance },
            { icon: "󰾅", profile: PowerProfile.Balanced },
            { icon: "󰾆", profile: PowerProfile.PowerSaver }
        ]
        BarButton {
            required property var modelData
            required property int index
            width: 55
            text: modelData.icon
            active: PowerProfiles.profile === modelData.profile
            bg: Colors.base00
            borderColor: Colors.base05
            hoverBg: active ? Colors.base04 : Colors.base02
            hoverFg: active ? Colors.base00 : Colors.base05
            activeBg: Colors.base05
            activeFg: Colors.base00
            onClicked: PowerProfiles.profile = modelData.profile
        }
    }
}

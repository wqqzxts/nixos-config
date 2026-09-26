import Quickshell
import Quickshell.Io
import QtQuick
import "../Config"
import "../Services"
import "../Widgets"

BarModule {
    id: language
    widgetWidth: 85
    menuBorder: false
    menuGap: Style.spacing + Style.shadow
    menuSpacing: Style.spacing + Style.shadow

    readonly property var names: Niri.keyboardNames
    readonly property int current: Niri.keyboardIndex
    readonly property string code: names.length > current ? shortName(names[current]) : ""

    function shortName(n) {
        if (n === "English (US)") return "US"
        if (n === "Russian") return "RU"
        return n.substring(0, 2).toUpperCase()
    }

    widgetContent: Label {
        anchors.fill: parent
        text: language.code
    }

    Repeater {
        model: language.names
        BarButton {
            required property string modelData
            required property int index
            width: 85
            text: language.shortName(modelData)
            active: index === language.current
            bg: Colors.base00
            borderColor: Colors.base05
            activeBg: Colors.base05
            activeFg: Colors.base00
            hoverBg: active ? Colors.base04 : Colors.base02
            hoverFg: active ? Colors.base00 : Colors.base05
            onClicked: Quickshell.execDetached(["niri", "msg", "action", "switch-layout", String(index)])
        }
    }
}

import Quickshell
import Quickshell.Io
import QtQuick
import "../Config"
import "../Services"
import "../Widgets"

BarModule {
    id: language
    widgetWidth: 85
    borderColor: Colors.base0D
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
            borderColor: Colors.base0D
            activeBg: Colors.base08
            activeFg: Colors.base00
            activeBorder: Colors.redDark
            onClicked: Quickshell.execDetached(["niri", "msg", "action", "switch-layout", String(index)])
        }
    }
}

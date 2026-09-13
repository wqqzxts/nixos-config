pragma Singleton
import QtQuick

QtObject {
    readonly property string fontFamily: "IosevkaTerm Nerd Font Propo"
    readonly property real fontSize: 16
    readonly property int barHeight: 55
    readonly property int barPadding: 5
    readonly property int border: 5
    readonly property int shadow: 5
    readonly property int keyLift: 2
    readonly property real ledgeDarken: 1.25
    readonly property int spacing: 5
    readonly property int animDuration: 375
    readonly property int menuMaxHeight: 450

    readonly property real springStiffness: 350
    readonly property real springDamping: 0.75
    readonly property real springEpsilon: 0.001
    readonly property var closeCurve: [0.85, 0.00, 0.25, 1.00, 1, 1]
    readonly property int closeDuration: 375
    readonly property int colorDuration: 225
    readonly property real bgAlpha: 0.9
}

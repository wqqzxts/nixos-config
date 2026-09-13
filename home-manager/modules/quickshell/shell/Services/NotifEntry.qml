import QtQuick

QtObject {
    property int id
    property var n
    property string appName
    property string summary
    property string body
    property int urgency
    property string icon
    property bool isTransient
    property int count: 1
    property double deadline: 0
    property bool closing: false
}

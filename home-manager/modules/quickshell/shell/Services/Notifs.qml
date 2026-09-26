pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import "../Config"

Singleton {
    id: store

    property bool dnd: false
    readonly property int popupLimit: 5
    property var popups: []
    property var history: []

    NotificationServer {
        keepOnReload: true
        bodySupported: true
        bodyMarkupSupported: true
        actionsSupported: true
        imageSupported: true
        persistenceSupported: true
        onNotification: n => store.add(n)
    }

    Component { id: entryComp; NotifEntry {} }

    function iconFor(n) {
        if (n.image !== "") return n.image
        if (n.appIcon !== "") return Quickshell.iconPath(n.appIcon, true)
        return ""
    }

    function add(n) {
        n.tracked = true
        const e = entryComp.createObject(store, {
            id: n.id, n: n,
            appName: n.appName, summary: n.summary,
            body: n.body.replace(/\n/g, "<br>"),
            urgency: n.urgency, icon: iconFor(n),
            isTransient: n.transient
        })
        const t = timeoutFor(e)
        e.deadline = t > 0 ? Date.now() + t : 0
        n.closed.connect(() => store.remove(e))

        const dup = popups.find(p => !p.closing && p.appName === e.appName && p.summary === e.summary && p.body === e.body)
        if (dup) {
            e.count = dup.count + 1
            if (dup.n) dup.n.dismiss()
        }

        if (!dnd) popups = popups.concat([e])
        history = [e].concat(history)
    }

    function hidePopup(e) {
        e.closing = true
        if (e.isTransient && e.n) e.n.expire()
    }

    function finishHide(e) {
        popups = popups.filter(p => p !== e)
        if (!history.includes(e)) e.destroy()
    }

    function remove(e) {
        e.n = null
        history = history.filter(h => h !== e)
        if (popups.includes(e)) e.closing = true
        else e.destroy()
    }

    function activate(e) {
        if (!e.n) return
        const acts = e.n.actions
        const a = acts.find(x => x.identifier === "default") ?? (acts.length ? acts[0] : null)
        if (a) a.invoke()
        e.n.dismiss()
    }

    function dismiss(e) { if (e.n) e.n.dismiss() }
    function dismissPopups() { popups.slice().forEach(p => { if (p.n) p.n.dismiss() }) }
    function clearHistory() { history.slice().forEach(h => { if (h.n) h.n.dismiss() }) }

    function timeoutFor(e) {
        if (e.n.expireTimeout > 0) return e.n.expireTimeout
        switch (e.urgency) {
        case NotificationUrgency.Critical: return 0
        default: return 5000
        }
    }

    function frameColor(urgency) {
        switch (urgency) {
        case NotificationUrgency.Critical: return Colors.base08
        case NotificationUrgency.Low: return Colors.base03
        default: return Colors.base05
        }
    }
}

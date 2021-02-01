import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.2
import Qt.labs.qmlmodels 1.0

import QtNotification 1.0
Page {
    property alias grid : grid
    property var numberProducts: 0
    width: 600
    height: 400

    Notification {
        id: notification
    }
    ScrollView {
        anchors.fill: parent
        Grid {
            id: grid
            width: 300; height: 200
            columns: 3
            spacing: 50
            anchors.centerIn: parent
            leftPadding: 30
            topPadding: 60
        }
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.5

Page{
    Rectangle {
        id: root
        anchors.fill: parent
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#F5CA66" }
            GradientStop { position: 1.0; color: "#FF8000" }
        }
        Row {
            width: parent.width
            height: 100
            anchors.verticalCenter: parent
            anchors.topMargin: 10
            Text {
                id: expirylabel
                text: "Ile dni do końca ważności"
                anchors.verticalCenter: parent.anchors.verticalCenter
                font.pointSize: 12
            }
            SpinBox {
                id: spinbox
                anchors.verticalCenter: parent
                from: 0
                to: 14
                value: ThingspeakData.alertRange

                onValueModified: {
                    ThingspeakData.alertRange = value
                    ThingspeakData.refreshEndExpiryModel()
                }
            }
        }
    }
}

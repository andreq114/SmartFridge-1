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
        Column{
            anchors.fill: parent
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                topPadding: 20
                bottomPadding: 40
                text: "Powiadomienia"
                font.pointSize: 20
                font.family: "Helvetica"
            }
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                bottomPadding: 10
                text: "Data ważności"
                font.pointSize: 15

            }

            Row {

                height: 100
                //anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                Text {
                    id: expirylabel
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    leftPadding: 15
                    text: "Dni do końca:"
                    font.pointSize: 12
                }
                SpinBox {
                    id: spinbox
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    //rightPadding: 15
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
}

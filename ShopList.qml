import QtQuick 2.12
import QtQuick.Controls 2.5

Page{
    anchors.fill: parent
    Rectangle {
        id: root
        anchors.fill: parent
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#F5CA66" }
            GradientStop { position: 1.0; color: "#FF8000" }
        }
        ListView {
            id: list
            anchors.fill: parent
            model: ThingspeakData.shoplist
            delegate:
                Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width
                height: 60
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    font.family: "Helvetica"
                    font.pixelSize: 14
                    text: modelData
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                    }
                }
            }
        }
    }
}


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
        ListView {
            id: list
            anchors.fill: parent
            model: ManagerQML.shoppinglist
            delegate:
                Rectangle {
                id: shopListRect
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width - 50
                height: width/6
                color: "transparent"

                Rectangle{
                    width: parent.width
                    anchors.bottom: parent.bottom
                    height: 1
                    color: "black"
                }
                Text {
                    anchors.centerIn: parent
                    font.pointSize: shopListRect.width/30
                    font.bold: true
                    text: modelData
                    wrapMode: Text.Wrap
                    width: parent.width

                }
            }
        }
    }
}


import QtQuick 2.12
import QtQuick.Controls 2.5

Page{
    anchors.fill: parent

    ListView {
        id: list
        anchors.fill: parent
        spacing: 10
        model: ThingspeakData.shoplist
        delegate:
            Row {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 30
            Text {
                font.family: "Helvetica"
                font.pixelSize: 25
                text: modelData
            }
        }


    }
}

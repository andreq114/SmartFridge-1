import QtQuick 2.12
import QtQuick.Controls 2.5

Page{
    Rectangle {
        anchors.fill: parent
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#F5CA66" }
            GradientStop { position: 1.0; color: "#FF8000" }
        }



        Rectangle{
            id: mainRect
            width: (parent.width*3)/4
            height: (parent.height*3)/4
            color: "transparent"
            anchors.centerIn: parent
            Flickable {
                id: settingsFlickable
                anchors.fill: parent
                contentHeight: settingsColumn.height
                contentWidth: settingsColumn.width
                boundsBehavior: Flickable.StopAtBounds
                clip: true
                Column{
                    id: settingsColumn
                    Image {
                        id: expireImage
                        width: settingsFlickable.width/5
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "qrc:/icons/icons/hourglass.png"
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        topPadding: 30
                        bottomPadding: 20
                        text: "Days to expire:"
                        font.pointSize: settingsFlickable.width/15
                    }

                    SpinBox {
                        id: spinbox
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: settingsFlickable.width/6
                        width: settingsFlickable.width
                        font.pixelSize: settingsFlickable/9

                        //anchors.right: parent.right
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
}

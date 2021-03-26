import QtQuick 2.12
import QtQuick.Controls 2.5

Page{

    Rectangle {
        anchors.fill: parent
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#F5CA66" }
            GradientStop { position: 1.0; color: "#FF8000" }
        }

        ListView {
            id: listtt
            anchors.fill: parent

            Rectangle{
                id: mainRect
                width: (parent.width*3)/4
                height: (parent.height*3)/4
                color: "transparent"
                anchors.centerIn: parent
                Column{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    //            Text{
                    //                anchors.horizontalCenter: parent.horizontalCenter
                    //                topPadding: 20
                    //                bottomPadding: 40
                    //                text: "Powiadomienia"
                    //                font.pointSize: 20
                    //                font.family: "Helvetica"
                    //            }
                    Image {
                        id: expireImage
                        width: parent.width/5
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "qrc:/icons/icons/hourglass.png"
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        topPadding: 30
                        bottomPadding: 20
                        text: "Days to expire:"
                        font.pointSize: parent.width/10
                    }

                    //            Row {
                    //                height: 100
                    //                width: parent.width
                    //                Text {
                    //                    id: expirylabel
                    //                    anchors.verticalCenter: parent.verticalCenter
                    //                    anchors.left: parent.left
                    //                    leftPadding: 15
                    //                    text: "Dni do końca:"
                    //                    font.pointSize: 15
                    //                }
                    SpinBox {
                        id: spinbox
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.width/5
                        width: parent.width
                        font.pixelSize: width/8

                        //anchors.right: parent.right
                        from: 0
                        to: 14
                        value: ThingspeakData.alertRange
                        onValueModified: {
                            ThingspeakData.alertRange = value
                        }
                    }
                    //}

                }
            }
        }
    }
}

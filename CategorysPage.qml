import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.2
import Qt.labs.qmlmodels 1.0
import QtGraphicalEffects 1.0

import QtNotification 1.0
Page {
    property alias grid : grid
    property var numberProducts: 0




    Notification {
        id: notification

    }

    Image {
        id: input
        source: "qrc:/background/icons/background.jpg"
        anchors.fill: parent

        OpacityMask {
            source: mask
            maskSource: input
        }

        LinearGradient {
            id: mask
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: "#FF8000" }
            }
        }
        Rectangle{
            id: categorysMainRect
            width: parent.width
            height: parent.height-50

            color: "transparent"

            Flickable {
                id: flick
                anchors.fill: parent
                contentWidth: grid.width
                contentHeight: grid.height
                clip: true
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.DragAndOvershootBounds
                //boundsBehavior: Flickable.OvershootBounds

                property var refreshFlik;
                property  var startYPosition;

                property var yPosEnd;
                property var yPosStart;

                //        rebound: Transition {
                //                NumberAnimation {
                //                    properties: "x,y"
                //                    duration: 1500
                //                    easing.type: Easing.OutBounce
                //                }
                //            }
                onFlickStarted: {
                    refreshFlik = atYBeginning

                    if (refreshFlik === true && verticalOvershoot < -100)
                    {
                        refreshIcon.visible = true
                        refreshIconAnimation.start()
                        ThingspeakData.refreshData();
                    }
                    console.log(categorysMainRect.width)

                    console.log(flick.width)

                    console.log(grid.width)
                }




                Rectangle{
                    width: 40
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"

                    Image {
                        id: refreshIcon
                        visible: false
                        anchors.centerIn: parent

                        width: 25
                        height: 25
                        source: "qrc:/menu_icons/icons/refreshing.png"

                        RotationAnimation on rotation {
                            id: refreshIconAnimation
                            loops: 4
                            from: 0
                            to: 360
                            duration: 500
                            onFinished: refreshIcon.visible = false
                        }

                    }
                }


                Grid {
                    id: grid
                    width: categorysMainRect.width
                    anchors.top: parent.top
                    columns: 3
                    spacing: categorysMainRect.width/20
                    //flow: Grid.TopToBottom
                    leftPadding: categorysMainRect.width/20
                    rightPadding: categorysMainRect.width/20
                    topPadding: categorysMainRect.width/10
                    bottomPadding: categorysMainRect.width/20


                }
                //                    topPadding: 90
                //                    leftPadding: 40
                //                    rightPadding: 40
            }

        }
    }
    Rectangle{
        width: parent.width
        height: 30
        color: "transparent"
        anchors.bottom: parent.bottom
        Text {
            id: updateText
            anchors.top: parent.top
            height: 30
            //anchors.right: parent.right
            //bottomPadding: 50
            width: parent.width
            leftPadding: 20
            text: "Last server update: " + Qt.formatDateTime(new Date(ThingspeakData.creatingDate), "dd.MM.yyyy hh:mm")
            font.pointSize: 12
        }
    }

}

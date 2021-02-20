import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.2
import Qt.labs.qmlmodels 1.0
import QtGraphicalEffects 1.0

import QtNotification 1.0
Page {
    property alias grid : grid
    property var numberProducts: 0
    width: 400
    height: 350

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
            anchors.fill: parent
            color: "transparent"
            Flickable {
                id: flick
                anchors.fill: parent
                contentWidth: parent.width
                contentHeight: parent.height
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.DragAndOvershootBounds
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
                    //console.log("Pozycja Y start")
                    //console.log(verticalOvershoot)
                    //console.log("FLick start")
                    if (refreshFlik === true && verticalOvershoot < -200)
                    {
                        //console.log("Refresh")
                        refreshIcon.visible = true
                        refreshIconAnimation.start()
                        ThingspeakData.refreshData();
                    }
                }

                //
                //  Slot called when the flick has finished
                //
                onFlickEnded: {
                    // console.log("Flick stop")
                    //            console.log(verticalOvershoot)
                    //            if (refreshFlik === true)
                    //            {
                    //                console.log("Refresh")
                    //                refreshIcon.visible = true
                    //                refreshIconAnimation.start()
                    //            }
                    //            console.log("Pozycja Y stop")
                    //            console.log(verticalOvershoot)

                }


                Rectangle{
                    width: 50
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"

                    Image {
                        id: refreshIcon
                        visible: false
                        anchors.centerIn: parent

                        width: 30
                        height: 30
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

                ScrollView {
                    anchors.fill: parent
                    Grid {
                        id: grid
                        width: parent.width
                        height: parent.height-20
                        anchors.top: parent.top
                        columns: 3
                        spacing: 50
                        //anchors.centerIn: parent
                        leftPadding: 30
                        topPadding: 40
                    }
                    Text {
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        bottomPadding: 10
                        width: parent.width
                        height: 20
                        leftPadding: 10
                        text: "Last update: " + Qt.formatDateTime(new Date(ThingspeakData.creatingDate), "dd.MM.yyyy hh:mm")
                        font.pointSize: 10
                    }



                }

            }


        }

    }

}

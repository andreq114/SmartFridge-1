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
                    notification.show({caption: "Expiriation date of some products is lower than 10 days, check it!", title : "Expiriation", id:0});
                    //console.log("Pozycja Y start")
                    //console.log(verticalOvershoot)
                    //console.log("FLick start")
                    if (refreshFlik === true && verticalOvershoot < -100)
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

                ScrollView {
                    anchors.fill: parent
                    Grid {
                        id: grid
                        width: parent.width
                        //height: parent.height
                        anchors.top: parent.top
                        columns: 3
                        spacing: 50
                        //anchors.centerIn: parent
                        leftPadding: 20
                        rightPadding: 20
                        topPadding: 50

                    }
                    Rectangle{
                        width: parent.width
                        height: 30
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        Text {
                            id: updateText
                            anchors.top: parent.top
                            //anchors.right: parent.right
                            //bottomPadding: 50
                            width: parent.width
                            height: 20
                            leftPadding: 20
                            text: "Last update: " + Qt.formatDateTime(new Date(ThingspeakData.creatingDate), "dd.MM.yyyy hh:mm")
                            font.pointSize: 12
                        }
                    }



                }

            }


        }

    }

}

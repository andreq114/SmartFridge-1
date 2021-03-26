import QtQuick 2.12
import QtQuick.Controls 2.5
//import QtQuick.Controls.Styles 1.0
import Qt.labs.qmlmodels 1.0
import QtGraphicalEffects 1.0

Page {
    property alias grid : grid
    property var numberProducts: 0

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

                property var refreshFlik;
                property  var startYPosition;

                property var yPosEnd;
                property var yPosStart;

                onFlickStarted: {
                    refreshFlik = atYBeginning

                    if (refreshFlik === true && verticalOvershoot < -100)
                    {
                        refreshIcon.visible = true
                        refreshIconAnimation.start()
                        ThingspeakData.refreshData();
                        ThingspeakData.refreshEndExpiryModel()

                    }
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
                    leftPadding: categorysMainRect.width/20
                    rightPadding: categorysMainRect.width/20
                    topPadding: categorysMainRect.width/10
                    bottomPadding: categorysMainRect.width/20

                    onWidthChanged: {
                        //ThingspeakData.refreshEndExpiryModel()
                        delay_2(5,function(){
                            console.log("FUNKCYTJKAAAAA")
                            ThingspeakData.refreshEndExpiryModel()
                        }
                            )

                        //ThingspeakData.refreshEndExpiryModel()
                    }

                }
            }

        }
    }
    Rectangle{
        width: parent.width
        height: 40
        color: "transparent"
        anchors.bottom: parent.bottom
        Text {
            id: updateText
            anchors.top: parent.top
            //height: 20
            width: parent.width
            bottomPadding: 10
            leftPadding: 20
            text: "Last server update: " + Qt.formatDateTime(new Date(ThingspeakData.creatingDate), "dd.MM.yyyy hh:mm")
            font.pointSize: 12
        }
        Text {
            id: refreshText
            anchors.bottom: parent.bottom
            //height: 20
            width: parent.width
            leftPadding: 20
            text: "Last refresh: " + ThingspeakData.refreshDate
            font.pointSize: 12
        }
    }

    function delay_2(delayTime_2, cb_2) {
        timer_2.interval = delayTime_2;
        timer_2.repeat = false;
        timer_2.triggered.connect(cb_2);
        timer_2.start();
    }
    Timer {
        id: timer_2
    }

}

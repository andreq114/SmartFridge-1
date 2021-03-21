import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQml 2.12
import QtGraphicalEffects 1.0

Page {
    id: myPage
    anchors.fill: parent
    Component.onCompleted: delay(4000,function(){
        mainStack.push(mainPagek)
    }
    )
    Rectangle{
        id: parentRect
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1E90FF" }
            GradientStop { position: 0.5; color: "#0000CD" }
            GradientStop { position: 1.0; color: "#00008B" }
        }

        Column{
            anchors.fill: parent

            Rectangle{
                width:  100
                height: 100
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                //gradient: parentRect.gradient

            }
            Flipable {
                id: flipable
                width: 250
                height: 250
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 100
                property bool flipped: false

                front: Image  { source: "qrc:/menu_icons/icons/logo_KI.png";width:140;height:140; anchors.centerIn: parent }
                back: Image { source: "qrc:/menu_icons/icons/logo_KI.png";width:140;height:140; anchors.centerIn: parent }

                transform: Rotation {
                    id: rotation
                    origin.x: flipable.width/2
                    origin.y: flipable.height/2
                    axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                    angle: 0                            // the default angle
                }

                states: State {
                    name: "back"
                    PropertyChanges { target: rotation; angle: 360 }
                    when: flipable.flipped
                }

                transitions: Transition {
                    NumberAnimation { target: rotation; property: "angle"; duration: 4000; loops: Animation.Infinite}
                }


                Component.onCompleted: flipable.flipped = !flipable.flipped

            }
            Rectangle{
                id: nameRect
                width:  320
                height: 170
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter

                Column{
                    anchors.fill: parent
                    Text {
                        height: parent.height/3
                        width: parent.width
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        style: Text.Raised
                        font.bold: true
                        font.pixelSize: 40
                        text: "PWSZ Tarnów"
                    }
                    Text {
                        height: parent.height/3
                        width: parent.width
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        style: Text.Raised
                        font.bold: true
                        font.pixelSize: 30
                        text: "Katedra Informatyki"
                    }
                }


            }

        }
    }



    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }
    Timer {
        id: timer
    }
}

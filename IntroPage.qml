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
        //color: "red"
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#F5CA66" }
            GradientStop { position: 0.33; color: "#FF8000" }
            GradientStop { position: 1.0; color: "#FF3C26" }
        }


        Column{
            anchors.fill: parent

            Rectangle{
                width:  320
                height: 170
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                //gradient: parentRect.gradient
                Image {
                    id: napis
                    height: 150
                    width: parent.width
                    anchors.centerIn: parent
                    source: "qrc:/menu_icons/icons/smart_fridge_napis.png"
                }
            }
            Flipable {
                id: flipable
                width: 250
                height: 250
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 100
                property bool flipped: false

                front: Image { source: "qrc:/menu_icons/icons/ikona_smart_fridge.png";width:250;height:250; anchors.centerIn: parent }
                back: Image { source: "qrc:/menu_icons/icons/logo_KI.png";width:220;height:220; anchors.centerIn: parent }

                transform: Rotation {
                    id: rotation
                    origin.x: flipable.width/2
                    origin.y: flipable.height/2
                    axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                    angle: 0    // the default angle
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



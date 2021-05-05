import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQml 2.12
import QtGraphicalEffects 1.0

Page {
    id: root
    anchors.fill: parent
    Component.onCompleted: delay(4000,function(){
        mainStack.push(mainPage)
    }
    )
    Rectangle{
        id: parentRect
        anchors.fill: parent
        color: "#006080"
        Flipable {
            id: flipable
            width: 250
            height: 250
            anchors.centerIn: parent
            anchors.topMargin: 100
            property bool flipped: false

            front: Image  { source: "qrc:/icons/icons/KI_LOGO.jpg";
                            width:parentRect.width/4;
                            height:width;
                            anchors.centerIn: parent }
            back: Image { source: "qrc:/icons/icons/KI_LOGO.jpg";
                          width:parentRect.width/4;
                          height:width;
                          anchors.centerIn: parent }

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

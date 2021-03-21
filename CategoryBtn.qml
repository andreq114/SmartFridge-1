import QtQuick 2.12

Item {
    id: root
    property string figure
    property int btnid
    signal clicked(int btnid)

    Rectangle {
        width: parent.width
        height: parent.height
        color: "white"
        anchors.centerIn: parent
        opacity: 0.3
        radius: width*0.3
    }

    Image {
        id: image
        width: (3*parent.width)/4
        height: (3*parent.height)/4
        z: 1
        anchors.centerIn: parent

        source: parent.figure

        MouseArea {
            anchors.fill: parent

            function delay(delayTime, cb) {
                timer.interval = delayTime;
                timer.repeat = false;
                timer.triggered.connect(cb);
                timer.start();
            }

            onClicked: {
                animation.start()
                delay(500,function(){
                    root.clicked(root.btnid)
                })
            }

            Timer {
                id: timer
            }

            SequentialAnimation {
                id: animation

                PropertyAnimation {
                    target: image
                    property: "opacity"

                    from: 1
                    to: 0.5
                    duration: 250
                }

                PropertyAnimation {
                    target: image
                    property: "opacity"

                    from: 0.5
                    to: 1
                    duration: 250
                }
            }
        }
    }

}

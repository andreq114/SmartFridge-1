import QtQuick 2.12

Item {
    id: root
    property string figure
    property int btnid
    signal clicked(int btnid)
    Image {
        id: image
        width: 75
        height: 75

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
                    //tabBar.visible = false
                    //swipeView.setCurrentIndex(1)
                    //productPage.listek.move(2)
                    //productView.listek.currentIndex=index

                    /*delay(5000,function(){
                        notification.show({
                        caption: "hello",
                        title  : "notification",
                        id     : Math.random()
                        });
                    }
                    )*/

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

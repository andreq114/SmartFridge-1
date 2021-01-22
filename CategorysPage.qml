import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.2
import Qt.labs.qmlmodels 1.0

import QtNotification 1.0
Page {
    width: 600
    height: 400
    title: qsTr("Categorys of products")

    Notification {
        id: notification
    }
    ScrollView {
        anchors.fill: parent
        Column {
            anchors.fill: parent
            width: 400
            height: 400


            //add: Transition {
            //        NumberAnimation { properties: "x,y"; from: 100; duration: 1000 }
            //    }
            //columnSpacing: 1
            //rowSpacing: 1
            //property var columnWidths: [100, 50, 80, 150]



            //Button

            Image {
                id: fish_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/fish.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        fish_animation.start()
                        delay(500,function(){
                            //tabBar.visible = false
                            swipeView.setCurrentIndex(1)
                            //productPage.listek.move(2)
                            productPage.listek.currentIndex=0
                            notification.show({
                                              caption: "hello",
                                              title  : "notification",
                                              id     : Math.random()
                                          });
                        })
                    }

                    SequentialAnimation {
                        id: fish_animation

                        PropertyAnimation {
                            target: fish_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: fish_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: dairy_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/dairy-products.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        animation_dairy.start()
                        delay(500,function(){
                            //tabBar.visible = false
                            swipeView.setCurrentIndex(1)
                            //productPage.listek.move(2)
                            productPage.listek.currentIndex=1
                        })
                    }

                    SequentialAnimation {
                        id: animation_dairy

                        PropertyAnimation {
                            target: dairy_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: dairy_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: ikona
                width: 75
                height: 75

                source: "qrc:/icons/icons/frozen-goods.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        animation.start()
                        delay(500,function(){
                            //tabBar.visible = false
                            swipeView.setCurrentIndex(1)
                            //productPage.listek.move(2)
                            productPage.listek.currentIndex=2
                        })
                    }

                    SequentialAnimation {
                        id: animation

                        PropertyAnimation {
                            target: ikona
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: ikona
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: healthy_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/healthy-food.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        healthy_animation.start()
                        //mymem.dupa(txtText)
                    }

                    SequentialAnimation {
                        id: healthy_animation

                        PropertyAnimation {
                            target: healthy_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: healthy_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: meat_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/meat.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        meat_animation.start()
                        delay(500,function(){
                            tabBar.visible = false
                            stackView.push("meat_page.qml");
                        })
                       // mymem.dupa(txtText)
                    }

                    SequentialAnimation {
                        id: meat_animation

                        PropertyAnimation {
                            target: meat_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: meat_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: plastic_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/plastic.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        plastic_animation.start()

                        //mymem.dupa(txtText)
                    }

                    SequentialAnimation {
                        id: plastic_animation

                        PropertyAnimation {
                            target: plastic_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: plastic_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: sauces_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/sauces.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        sauces_animation.start()
                        delay(500,function(){
                            tabBar.visible = false
                            stackView.push("sauces_page.qml");
                        })
                        //mymem.dupa(txtText)
                    }

                    SequentialAnimation {
                        id: sauces_animation

                        PropertyAnimation {
                            target: sauces_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: sauces_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: drink_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/soft-drink.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        drink_animation.start()
                       delay(500,function(){
                            tabBar.visible = false
                            stackView.push("fish_page.qml");
                        })
                        //mymem.dupa(txtText)
                    }

                    SequentialAnimation {
                        id: drink_animation

                        PropertyAnimation {
                            target: drink_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: drink_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: sweets_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/sweets.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        sweets_animation.start()
                        delay(500,function(){
                            tabBar.visible = false
                            stackView.push("sweets_page.qml");
                        })
                        //mymem.dupa(txtText)
                    }

                    SequentialAnimation {
                        id: sweets_animation

                        PropertyAnimation {
                            target: sweets_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: sweets_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
            Image {
                id: glass_icon
                width: 75
                height: 75

                source: "qrc:/icons/icons/glass.png"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        glass_animation.start()

                    }

                    SequentialAnimation {
                        id: glass_animation

                        PropertyAnimation {
                            target: glass_icon
                            property: "opacity"

                            from: 1
                            to: 0.5
                            duration: 250
                        }

                        PropertyAnimation {
                            target: glass_icon
                            property: "opacity"

                            from: 0.5
                            to: 1
                            duration: 250
                        }
                    }
                }
            }
        }


    }
    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

}


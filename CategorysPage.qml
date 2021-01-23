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

        Grid {
            width: 300; height: 200
            columns: 3
            spacing: 30
            anchors.centerIn: parent
            padding: 40
            //add: Transition {
            //        NumberAnimation { properties: "x,y"; from: 100; duration: 1000 }
            //    }
            //columnSpacing: 1
            //rowSpacing: 1
            //property var columnWidths: [100, 50, 80, 150]



            //Button
            CategoryBtn {
                figure : "qrc:/icons/icons/fish.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  0
                }
            }
            CategoryBtn {
                figure : "qrc:/icons/icons/dairy-products.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  1
                }
            }
            CategoryBtn {
                figure : "qrc:/icons/icons/frozen-goods.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  2
                }
            }
            CategoryBtn {
                figure : "qrc:/icons/icons/healthy-food.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  3
                }
            }
            CategoryBtn {
                figure : "qrc:/icons/icons/meat.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  4
                }
            }
            CategoryBtn {
                figure : "qrc:/icons/icons/plastic.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  5
                }
            }
            CategoryBtn {
                figure :  "qrc:/icons/icons/sauces.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  6
                }
            }
            CategoryBtn {
                figure :  "qrc:/icons/icons/soft-drink.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  7
                }
            }
            CategoryBtn {
                figure :  "qrc:/icons/icons/sweets.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  8
                }
            }
            CategoryBtn {
                figure :  "qrc:/icons/icons/glass.png"
                width: 75
                height: 75

                onClicked: {
                    swipeView.setCurrentIndex(1)
                    productPage.listek.currentIndex =  9
                }
            }

        }
    }
}

import QtQuick 2.12
//import TableModel 0.1
import QtQuick.Controls 2.5
//import QtQml 2.15

Page {

    property alias listek: listek
    //property int indeksik: 1

    ListView {
        id: listek
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration : 1000

        //currentIndex: indeksik
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        model: ListModel {
            id: listModel

            ListElement {
                iconSourc: "qrc:/icons/icons/fish.png"
                tekst: "Fish"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/dairy-products.png"
                tekst: "Dairy"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/frozen-goods.png"
                tekst: "Frozen"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/healthy-food.png"
                tekst: "Fruits and vegetables"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/meat.png"
                tekst: "Meats"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/plastic.png"
                tekst: "Water"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/sauces.png"
                tekst: "Sauces"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/soft-drink.png"
                tekst: "Drinks"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/sweets.png"
                tekst: "Sweets"
            }
            ListElement {
                iconSourc: "qrc:/icons/icons/glass.png"
                tekst: "Alcohol"
            }
        }

        delegate: OneCategoryProducts {
            icon_source: iconSourc
            icon_tekst: tekst
            width:  ListView.view.width
            height: ListView.view.height
        }

    }

/*
    TableView {
        anchors.fill: parent
        columnSpacing: 5
        rowSpacing: 5
        clip: true


        model: TableModel {

        }

        delegate : Image {
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
        }*/
    }





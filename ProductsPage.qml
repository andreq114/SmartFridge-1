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
        clip: true
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
                indeks: 0
                iconSourc: "qrc:/icons/icons/fish.png"
                visib: true
                tekst: "Fish"
            }
            ListElement {
                indeks: 1
                iconSourc: "qrc:/icons/icons/dairy-products.png"
                visib: true
                tekst: "Dairy"
            }
            ListElement {
                indeks: 2
                iconSourc: "qrc:/icons/icons/frozen-goods.png"
                visib: true
                tekst: "Frozen"
            }
            ListElement {
                indeks: 3
                iconSourc: "qrc:/icons/icons/healthy-food.png"
                visib: true
                tekst: "Fruits and vegetables"
            }
            ListElement {
                indeks: 4
                iconSourc: "qrc:/icons/icons/meat.png"
                visib: true
                tekst: "Meats"
            }
            ListElement {
                indeks: 5
                iconSourc: "qrc:/icons/icons/plastic.png"
                visib: true
                tekst: "Water"
            }
            ListElement {
                indeks: 6
                iconSourc: "qrc:/icons/icons/sauces.png"
                visib: true
                tekst: "Sauces"
            }
            ListElement {
                indeks: 7
                iconSourc: "qrc:/icons/icons/soft-drink.png"
                visib: false
                tekst: "Drinks"
            }
            ListElement {
                indeks: 8
                iconSourc: "qrc:/icons/icons/sweets.png"
                visib: false
                tekst: "Sweets"
            }
            ListElement {
                indeks: 9
                iconSourc: "qrc:/icons/icons/glass.png"
                visib: true
                tekst: "Alcohol"
            }
        }

        delegate: OneCategoryProducts {
            icon_source: iconSourc
            icon_tekst: tekst
            visible: visib
            width:  ListView.view.width
            height: visible === false ? 0 : ListView.view.height
            fullList_Model.model: indeks === 0 ? fishModel : indeks === 1 ? dairyModel : indeks === 2 ? frozenModel : fruitsModel
            //fullList_Model.model: modelik
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





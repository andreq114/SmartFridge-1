import QtQuick 2.12

import QtQuick.Controls 2.5

//Page{
//    anchors.fill: parent

//    Text {
//        anchors.centerIn: parent
//        text: "This application was created by Kamil Wielgosz and Andrzej Przybyło\n as a part of Smart Fridge system which will conquere the market \u2665 "
//    }
//}

Item{
        id: root
        width: 1406; height: 536

        ListModel {
            id: animalsModel
            ListElement { name: "Puss in Boots"; type: "Cats"; aVisible: false}
            ListElement { name: "Bengal"; type: "Cats"; aVisible: false }
            ListElement { name: "Pug"; type: "Dogs"; aVisible: false }
            ListElement { name: "German Shepherd"; type: "jjj"; aVisible: false }
            ListElement { name: "Parrot"; type: "huj"; aVisible: false }
        }

        Component {
            id: sectionHeader

            Rectangle {
                id: sectionHeaderRect
                width: 181
                color:"green"
                height: 50

                property bool isExpanded: false
                property string currentExpandedSection: ListView.view.expandedSection

                onCurrentExpandedSectionChanged: {
                    if(currentExpandedSection === section)
                        isExpanded = true;
                    else
                        isExpanded = false;
                }

                onIsExpandedChanged: {
                    if(isExpanded){
                        color = "blue";
                        ListView.view.expandedSection = section;
                    }
                    else
                        color = "green";
                    for(var i=0; i<animalsModel.count; i++){
                        var animal = animalsModel.get(i);
                        if(section === animal.type)
                            animal.aVisible = sectionHeaderRect.isExpanded;
                    }
                }

                Text {
                    id: sectionHeaderText
                    text: section
                    anchors.centerIn: parent
                }



                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        sectionHeaderRect.isExpanded = !sectionHeaderRect.isExpanded;
                    }
                }
            }
        }


        ListView {
            id: listing
            width: 181
            height: parent.height
            model: animalsModel

            property string expandedSection: ""

            delegate: listdelegate

            section.property: "type"
            section.criteria: ViewSection.FullString
            section.delegate: sectionHeader

        }

        Component {
            id: listdelegate

            Rectangle {
                id: menuItem
                width: 181
                //height: 55
                color: ListView.isCurrentItem ? "lightblue" : "white"
                visible: aVisible

                onVisibleChanged: {
                    if(visible)
                        height = 55;
                    else
                        height = 0;
                }

                Behavior on height {
                    NumberAnimation { duration: 1000 }
                }

                Text {
                    id: text
                    text: name
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listing.currentIndex = index;
                    }
                }
            }
        }
    }

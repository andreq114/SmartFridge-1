import QtQuick 2.12
import QtQuick.Window 2.12
//import com.ProductsTable 0.1
import QtQuick.Controls 2.5
//import QtQuick.Controls 1.4 as C1
import Qt.labs.qmlmodels 1.0

Page{

    property alias icon_source: myIcon.source
    property alias icon_tekst: nazwa.text
    property alias fullList_Model: fullListModel
    //ScrollView{
    Column{
        anchors.fill: parent
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            topPadding: 30
            Image {
                anchors.verticalCenter:  parent.verticalCenter
                width: 50
                height: 50
                id: myIcon
            }
            Text {
                id: nazwa
                anchors.verticalCenter:  parent.verticalCenter
                font.family: "Helvetica"
                font.pixelSize: 25
                color: "white"
            }


        }

        Rectangle {
            width: parent.width; height: parent.height-30-myIcon.height
            Rectangle {
                id: grandparent
                width: parent.width-50; height: parent.height-30-myIcon.height
                anchors.centerIn: parent

                Component {
                    id: sectionHeader

                    Rectangle {
                        id: sectionHeaderRect
                        width: grandparent.width
                        height: 60
                        color: "white"

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
                                color = "lightgray";
                                ListView.view.expandedSection = section;
                                for(var i=0; i<fullListModel.model.rowCount(); i++){
                                    var product = fullListModel.model.data(fullListModel.model.index(i,2));
                                    if(section === product)
                                    {
                                        fullListModel.model.setData(fullListModel.model.index(i,2),sectionHeaderRect.isExpanded);
                                    }
                                }
                            }
                            else{
                                color = "white";
                                for(i=0; i<fullListModel.model.rowCount(); i++){
                                    product = fullListModel.model.data(fullListModel.model.index(i,2));
                                    if(section === product)
                                    {
                                        fullListModel.model.setData(fullListModel.model.index(i,2),sectionHeaderRect.isExpanded);
                                    }
                                }
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
                    id: fullListModel
                    anchors.fill: parent
                    delegate: contactDelegate

                    property string expandedSection: ""

                    section.property: "description"
                    section.criteria: ViewSection.FullString
                    section.delegate: sectionHeader
                    //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                    //focus: true
                }

                Component {
                    id: contactDelegate
                    Rectangle {
                        color: fullListModel.isCurrentItem ? "lightblue" : "white"
                        visible: aVisible
                        width: grandparent.width
                        onVisibleChanged: {
                            if(visible){
                                height = 60;
                            }else{
                                height = 0;
                            }
                        }

                        Behavior on height {
                            NumberAnimation { duration: 1000 }
                        }

                        Text {
                            id: text
                            text: exp_date
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                fullListModel.currentIndex = index;
                            }
                        }
                    }
                }
            }

        }



    }

}


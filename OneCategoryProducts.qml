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
    Rectangle{
        id: root
        anchors.fill: parent
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#F5CA66" }
            GradientStop { position: 1.0; color: "#FF8000" }
        }


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
                color: "black"
            }


        }

        Rectangle {
            width: parent.width; height: parent.height-30-myIcon.height
            gradient: root.gradient
            Rectangle {
                id: grandparent
                width: parent.width-50; height: parent.height-30-myIcon.height
                anchors.centerIn: parent
                color: "transparent"
                Component {
                    id: sectionHeader

                    Rectangle {
                        id: sectionHeaderRect
                        width: grandparent.width
                        height: 60
                        color: "transparent"
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
                                color = "transparent";
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
                            font.pointSize: 10
                            font.bold: true
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
                        color: expire ? "red" : "transparent"
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
                            text:   Qt.formatDateTime(new Date(exp_date), "dddd dd.MM.yyyy")
                            anchors.centerIn: parent
                            font.pointSize: 11
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
}

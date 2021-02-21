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
    property bool visib: false
    property bool exp: false
    onExpChanged: {
        //visib = false
    }



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
            PinchArea{
                anchors.fill: parent
                onPinchFinished: visib = !visib
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
                            if(currentExpandedSection === section){
                                console.log("Zmiana currentExpandedSection na true")
                                isExpanded = true;
                            }else{
                                isExpanded = false;
                                console.log("Zmiana currentExpandedSection na false")
                            }
                        }

                        onIsExpandedChanged: {
                            if(isExpanded){
                                console.log("Zmiana isExpanded na true")
                                visib = true;
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
                                 console.log("Zmiana isExpanded na false")
                                visib = false;
                                color = "white"
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
                            font.pointSize: 15
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
                    //snapMode: ListView.snapMode
                    boundsBehavior: Flickable.StopAtBounds
                    clip: true
                    property string expandedSection: ""

                    section.property: "description"
                    section.criteria: ViewSection.FullString
                    section.delegate: sectionHeader

                    //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

                }

                Component {
                    id: contactDelegate
                    Rectangle {
                        id: rectek
                        //color: expire ? "red" : "transparent"
                        color: "transparent"
                        visible: visib
                        //visible: aVisible
                        width: grandparent.width
                        onVisibleChanged: visible ? height = 50 : height = 0


                        Behavior on height {
                            NumberAnimation { duration: 500 }
                        }

                        Text {
                            id: text
                            color: expire ? "red" : "black"
                            text:   Qt.formatDateTime(new Date(exp_date), "dddd dd.MM.yyyy")
                            anchors.centerIn: parent
                            font.pointSize: 12
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
}

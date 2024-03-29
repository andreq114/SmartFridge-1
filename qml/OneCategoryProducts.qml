import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import QtGraphicalEffects 1.0

Page{

    property alias icon_source: myIcon.source
    property alias icon_tekst: nazwa.text
    property alias fullList_Model: fullListModel
    property bool visib: false
    property bool twoFingers: false


    Rectangle{
        id: root
        anchors.fill: parent

        color: "transparent"

        Image {
            id: input
            source: "qrc:/background/icons/insideFridge.png"
            anchors.fill: parent

            OpacityMask {
                source: mask
                maskSource: input
            }

            LinearGradient {
                id: mask
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FF8C00" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
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
                        font.pixelSize: 35
                        font.bold: true
                        color: "black"
                    }


                }

                Rectangle {
                    width: parent.width; height: parent.height-30-myIcon.height-2
                    color: "transparent"
                    ScrollView{
                        anchors.fill: parent
                        PinchArea{
                            anchors.fill: parent
                            onPinchFinished: {
                                twoFingers = true
                                visib = !visib
                            }

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
                                                isExpanded = true;
                                            }else{
                                                isExpanded = false;
                                            }
                                        }

                                        onIsExpandedChanged: {
                                            if(isExpanded){
                                                visib = true;
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
                                                visib = false;
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
                                            wrapMode: Text.Wrap
                                            width: parent.width
                                        }

                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                twoFingers = false;
                                                sectionHeaderRect.isExpanded = !sectionHeaderRect.isExpanded;
                                            }
                                        }
                                        Rectangle{
                                            id: lineRect
                                            width: parent.width; height: 1
                                            anchors.top: parent.top
                                            color: "black"
                                        }
                                    }

                                }

                                ListView {
                                    id: fullListModel
                                    anchors.fill: parent

                                    delegate: contactDelegate
                                    boundsBehavior: Flickable.StopAtBounds
                                    clip: true
                                    cacheBuffer: 20000

                                    property string expandedSection: ""

                                    section.property: "description"
                                    section.criteria: ViewSection.FullString
                                    section.delegate: sectionHeader

                                    Component {
                                        id: contactDelegate
                                        Rectangle {
                                            id: rectek
                                            color: "transparent"
                                            visible: twoFingers === false ? aVisible : visib
                                            width: grandparent.width
                                            height: visible ? 50 : 0


                                            Behavior on height {
                                                NumberAnimation { duration: 500 }
                                            }

                                            Text {
                                                id: text
                                                color: {
                                                    if(redTerm)
                                                        return "red"
                                                    else if(yellowTerm)
                                                        return "yellow"
                                                    else
                                                        return "green"
                                                }
                                                text:   Qt.formatDateTime(new Date(exp_date), "dddd dd.MM.yyyy")
                                                anchors.centerIn: parent
                                                font.pointSize: 14
                                                font.bold: true
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    fullListModel.currentIndex = index;
                                                }
                                            }
                                            Component.onDestruction: aVisible = false
                                        }

                                    }
                                    Component.onCompleted: {
                                        fullListModel.currentIndex = -1;
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

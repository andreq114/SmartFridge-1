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
            Rectangle{
                id: grandparent
                width: parent.width-50; height: parent.height-30-myIcon.height
                anchors.centerIn: parent
            Component {
                id: contactDelegate
                Item {

                    width: grandparent.width; height: 40
                    Row {
                        Rectangle{
                            //border.color: "red"
                            //border.width: 10
                            height: 40
                            width: grandparent.width/2+50
                            Text {
                                text: description }
                        }
                        Rectangle{
                            //border.color: "blue"
                            //border.width: 10
                            height: 40
                            width:grandparent.width/2-50
                            Text { text: exp_date }
                        }
                    }
                }
            }

            ListView {
                id: fullListModel
                anchors.fill: parent
                //model:  listek.currentIndex === 0 ? fishModel : dairyModel
                model: listek.currentIndex === 0 ? fishModel : listek.currentIndex === 1 ? dairyModel : listek.currentIndex === 2 ? frozenModel : fruitsModel

                delegate: contactDelegate
                //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                //focus: true
            }
        }

}



    }

}



    /*ProductsTableView{
        height: parent.height-myIcon.height-30
        width: parent.width-50
        anchors.horizontalCenter: parent.horizontalCenter
        col1_width: width/2+50
        col2_width: width/2-50
    }*/








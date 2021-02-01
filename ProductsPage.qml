import QtQuick 2.12
import QtQuick.Controls 2.5
import com.mycompany.product 1.0
import com.mycompany.qmldata 1.0
import com.mycompany.productsTableModel 1.0

Page {

    property alias list: list
    property alias listModel: categoryModel

    ListView {
        id: list
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration : 1000
        clip: true
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        model: categoryModel

        delegate:
            OneCategoryProducts {
            icon_source: iconSourc
            icon_tekst: name
            width:  ListView.view.width
            height: ListView.view.height
            fullList_Model.model: createTableProducts(category)

            function createTableProducts(category) {
                for(var i = 0; i < ThingspeakData.amountCategories ; i++)
                {
                    if(category === ThingspeakData.groupModels[i].category)
                    {
                        console.log("FF");
                        return ThingspeakData.groupModels[i];
                    }
                }
            }
        }
        //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

        //height: visible === false ? 0 : ListView.view.height
        //fullList_Model.model: modelik


        // focus: true

    }

    ListModel {
        id: categoryModel
    }
}





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
        highlightMoveDuration : 500
        highlightMoveVelocity: -1
        cacheBuffer: 4000
        clip: true
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        model: ListModel {
            id: categoryModel
        }

        delegate: OneCategoryProducts {
            icon_source: iconSourc
            icon_tekst: name
            width:  ListView.view.width
            height: ListView.view.height
            fullList_Model.model: createTableProducts(category)


            function createTableProducts(category) {
                console.log("FUN");
                if(category == null)
                    return;
                for(var i = 0; i < ManagerQML.amountCategories ; i++)
                {
                    if(category === ManagerQML.groupModels[i].category)
                    {
                        return ManagerQML.groupModels[i];
                    }
                }
            }
        }
    }
}






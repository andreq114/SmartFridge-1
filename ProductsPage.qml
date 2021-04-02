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
        highlightMoveDuration : 20000
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
//            fullList_Model.model:
//                {
//                    console.log("Delegata: " + category);
//                    console.log(list.model.count);
//                    createTableProducts(category)
//                }

            function createTableProducts(category) {
                console.log("FUN");
                if(category == null)
                    return;

                //console.log("FOR" + ThingspeakData.amountCategories );
                for(var i = 0; i < ThingspeakData.amountCategories ; i++)
                {
                    //console.log(i);
                    //console.log("///" + ThingspeakData.groupModels[i].category);
                    //console.log("//////" + category);
                    if(category === ThingspeakData.groupModels[i].category)
                    {
                        //console.log("//////" + ThingspeakData.groupModels[i].category + "wloz");
                        return ThingspeakData.groupModels[i];
                    }
                }
            }

            Component.onCompleted: {
                console.log("Delegata zrobiony " + category);
                fullList_Model.model = createTableProducts(category)
                //{
                    //console.log("Delegata: " + category);
                    //console.log(list.model.count);

                //}
            }
            Component.onDestruction: {
                console.log("Delegata niszczony " + category);
            }
        }

    }
}






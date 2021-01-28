import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.2
import Qt.labs.qmlmodels 1.0
import com.mycompany.product 1.0
import com.mycompany.qmldata 1.0
import com.mycompany.groupproducts 1.0

import QtNotification 1.0
Page {
    width: 600
    height: 400
    title: qsTr("Categorys of products")

    Notification {
        id: notification
    }
    ScrollView {
        anchors.fill: parent

        Grid {
            id: grid
            width: 300; height: 200
            columns: 3
            spacing: 50
            anchors.centerIn: parent
            leftPadding: 30
            topPadding: 60

            property var size: 0

            function loadButton() {
                console.log("Found: " + ThingspeakData.groupProducts.length + " categories");
                size = 0;
                grid.children = ""
                for(var i=0 ; i<ThingspeakData.groupProducts.length ; i++){
                    switch(ThingspeakData.groupProducts[i].category) {
                    case Product.Dairy :
                        createBtnCategory("qrc:/icons/icons/dairy-products.png");
                        break;
                    case Product.Drinks :
                        createBtnCategory("qrc:/icons/icons/soft-drink.png");
                        break;
                    case Product.Alcohols :
                        createBtnCategory("qrc:/icons/icons/glass.png");
                        break;
                    case Product.Sauces :
                        createBtnCategory("qrc:/icons/icons/sauces.png");
                        break;
                    case Product.Sweets :
                        createBtnCategory("qrc:/icons/icons/sweets.png");
                        break;
                    case Product.Fishes :
                        createBtnCategory("qrc:/icons/icons/fish.png");
                        break;
                    case Product.Meat :
                        createBtnCategory("qrc:/icons/icons/meat.png");
                        break;
                    case Product.Frozen :
                        createBtnCategory("qrc:/icons/icons/frozen-goods.png");
                        break;
                    case Product.Plants :
                        createBtnCategory("qrc:/icons/icons/healthy-food.png");
                        break;
                    default :
                        console.log("Unknown a category");
                    }
                }
            }

            function buttonClicked(btnid) {
                swipeView.setCurrentIndex(1)
                productPage.listek.currentIndex = btnid
            }

            function createBtnCategory(path) {
                var component = Qt.createComponent("CategoryBtn.qml");
                if (component.status === Component.Ready) {
                    var button = component.createObject(grid,
                                                        {figure:  path
                                                            , width: 75
                                                            ,height: 75
                                                            , btnid: grid.size});
                    button.clicked.connect(buttonClicked)
                    grid.size++;
                }
            }

            Component.onCompleted: loadButton()
            Connections {
                            target: ThingspeakData
                            onGroupProductsChanged: loadButton();
                        }
        }
    }
}

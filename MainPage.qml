import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.0

import com.mycompany.product 1.0
import com.mycompany.qmldata 1.0
import com.mycompany.productsTableModel 1.0

Page {
    anchors.fill: parent
    id: window
    property var set

    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        contentWidth: parent.width
        Material.background: "#3C3C3C"
        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: toolButton

                icon.color: "transparent"
                icon.source: stackView.depth > 1 ? "qrc:/menu_icons/icons/return.png" : "qrc:/menu_icons/icons/menu.png"
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                onClicked: {
                    if(stackView.currentItem === set)
                        ThingspeakData.refreshEndExpiryModel()
                    if (stackView.depth > 1) {
                        stackView.pop()
                        titleLabel.text = swipeView.currentIndex == 0 ? "Categories" : "Products"
                    } else {
                        drawer.open()
                    }


                }
            }

            Label {
                id: titleLabel
                text: swipeView.currentIndex == 0 ? "Categories" : "Products"
                elide: Label.ElideRight
                anchors.centerIn: parent
                font.pointSize: 15
            }
        }
    }
    Drawer {
        id: drawer
        width: window.width * 0.5
        height: window.height
        Material.theme: Material.Background
        Column {
            anchors.fill: parent

            ItemDelegate {
                width: parent.width
                height: 50
                Row {
                    height: parent.height
                    ToolSeparator {
                        width: 10
                    }
                    Image {
                        id: shoplist
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent
                        source: "qrc:/menu_icons/icons/shopping-cart.png"
                    }
                    ToolSeparator {
                        width: 20
                    }
                    Text {
                        //anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 15
                        text: qsTr("<b>Shopping List</b>")
                    }
                }
                onClicked: {
                    stackView.push("ShopList.qml")
                    titleLabel.text = "Shopping List"
                    drawer.close()
                }
            }

            ItemDelegate {
                width: parent.width
                height: 50
                Row {
                    //anchors.fill: parent
                    height: parent.height
                    //anchors.verticalCenter: parent
                    ToolSeparator {
                        width: 10
                    }
                    Image {
                        id: settings_i
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent
                        source: "qrc:/menu_icons/icons/adjust.png"
                    }
                    ToolSeparator {
                        width: 20
                    }
                    Text {
                        //anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 15
                        text: qsTr("<b>Settings</b>")
                    }
                }
                onClicked: {
                    stackView.push("settings.qml")
                    set = stackView.get(1)
                    titleLabel.text = "Settings"
                    drawer.close()
                }
            }

            ItemDelegate {
                width: parent.width
                height: 50
                Row {
                    //anchors.fill: parent
                    height: parent.height
                    //anchors.verticalCenter: parent
                    ToolSeparator {
                        width: 10
                    }
                    Image {
                        id: aboutUs_i
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent
                        source: "qrc:/menu_icons/icons/adjust.png"
                    }
                    ToolSeparator {
                        width: 20
                    }
                    Text {
                        //anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 15
                        text: qsTr("<b>About us</b>")
                    }
                }
                onClicked: {
                    stackView.push("AboutUs.qml")
                    titleLabel.text = "About Us"
                    drawer.close()
                }
            }
        }
    }


    /*footer : TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Categorys")
        }
        TabButton {
            text: qsTr("Products")
        }
    }*/
    SwipeView {
        id: swipeView

        //currentIndex: tabBar.currentIndex

        CategorysPage {
            id: categoryPage
        }

        ProductsPage {
            id: productPage
        }
    }

    StackView {
        id: stackView
        initialItem: swipeView
        anchors.fill: parent
    }
    property var names : ["Dairy",
        "Drinks",
        "Alcohols",
        "Sauces",
        "Sweets",
        "Fishes",
        "Meat",
        "Frozen",
        "Fruits & Vegetables",
        "End of Expiry"];

    property var amountCategories : 0;

    function refreshPages() {
        console.log("Found: " + ThingspeakData.amountCategories + " categories");
        amountCategories = 0;
        categoryPage.grid.children = "";
        productPage.listModel.clear();
        for(var i=0 ; i<ThingspeakData.amountCategories ; i++){
            var category = ThingspeakData.groupModels[i].category;
            switch(category) {
            case Product.Dairy :
                createBtnCategory("qrc:/icons/icons/dairy-products.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/dairy-products.png" , name: names[0], category: category});
                amountCategories++;
                break;
            case Product.Drinks :
                createBtnCategory("qrc:/icons/icons/soft-drink.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/soft-drink.png" , name: names[1], category: category});
                amountCategories++;
                break;
            case Product.Alcohols :
                createBtnCategory("qrc:/icons/icons/glass.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/glass.png" , name: names[2], category: category});
                amountCategories++;
                break;
            case Product.Sauces :
                createBtnCategory("qrc:/icons/icons/sauces.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/sauces.png" , name: names[3], category: category});
                amountCategories++;

                break;
            case Product.Sweets :
                createBtnCategory("qrc:/icons/icons/sweets.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/sweets.png" , name: names[4], category: category});
                amountCategories++;
                break;
            case Product.Fishes :
                createBtnCategory("qrc:/icons/icons/fish.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/fish.png" , name: names[5], category: category});
                amountCategories++;
                break;
            case Product.Meat :
                createBtnCategory("qrc:/icons/icons/meat.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/meat.png" , name: names[6], category: category});
                amountCategories++;
                break;
            case Product.Frozen :
                createBtnCategory("qrc:/icons/icons/frozen-goods.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/frozen-goods.png" , name: names[7], category: category});
                amountCategories++;
                break;
            case Product.Plants :
                createBtnCategory("qrc:/icons/icons/healthy-food.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/healthy-food.png" , name: names[8], category: category});
                amountCategories++;
                break;
            case Product.EndOfExpiry :
                createBtnCategory("qrc:/icons/icons/hourglass.png");
                productPage.listModel.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/hourglass.png" , name: names[9], category: category});
                amountCategories++;
                break;
            default :
                console.log("Unknown a category");
            }
        }
    }

    function buttonClicked(btnid) {
        swipeView.setCurrentIndex(1)
        productPage.list.currentIndex = btnid
        //ThingspeakData.test();
    }

    function createBtnCategory(path) {
        var component = Qt.createComponent("CategoryBtn.qml");
        if (component.status === Component.Ready) {
            var button = component.createObject(categoryPage.grid,
                                                {figure:  path
                                                    , width: (categoryPage.grid.width-categoryPage.grid.leftPadding-categoryPage.grid.rightPadding-2*categoryPage.grid.spacing)/3
                                                    , height: (categoryPage.grid.width-categoryPage.grid.leftPadding-categoryPage.grid.rightPadding-2*categoryPage.grid.spacing)/3
                                                    , btnid: amountCategories});
            button.clicked.connect(buttonClicked)
        }
    }

    Component.onCompleted: refreshPages()

    Connections {
        target: ThingspeakData
        onGroupProductsChanged: refreshPages();
    }
}

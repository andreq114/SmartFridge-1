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
    property alias titleLabelek: titleLabel

    header: ToolBar {
        id: mainToolBar
        //contentHeight: toolButton.implicitHeight
        contentHeight: window.height/11
        contentWidth: window.width

        Material.background: "#3C3C3C"
        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: toolButton
                height: (parent.height*3)/4
                width: height
                icon.color: "transparent"
                icon.source: stackView.depth > 1 ? "qrc:/menu_icons/icons/return_arrow.png" : "qrc:/menu_icons/icons/menu.png"
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                onClicked: {
                    if(stackView.currentItem === set)
                        ThingspeakData.refreshEndExpiryModel()
                    if (stackView.depth > 1) {
                        console.log("Index:")
                        console.log(swipeView.currentIndex)
                        titleLabel.text = swipeView.currentIndex === 0 ? "Categories" : "Products"
                        stackView.pop()

                    } else {
                        drawer.open()
                    }
                }
            }

            Label {
                id: titleLabel
                text: swipeView.currentIndex === 0 ? "Categories" : "Products"
                elide: Label.ElideRight
                anchors.centerIn: parent
                font.pixelSize: 20
            }
        }
    }
    Drawer {
        id: drawer
        width: window.width * 0.5
        height: window.height
        Material.theme: Material.Background
        Flickable{
            id: drawerFlickable
            anchors.fill: parent
            contentWidth: drawerColumn.width
            contentHeight: drawerColumn.height
            boundsBehavior: Flickable.StopAtBounds
            clip: true
        Column {
            id: drawerColumn
            Rectangle {
                width: drawerFlickable.width
                height: width/4
                color:"#3C3C3C"
                Text{
                    anchors.centerIn: parent
                    wrapMode: Text.Wrap
                    text: "Menu"
                    font.pixelSize: drawerFlickable.width/10
                    font.bold: true
                    color: "white"

                }
            }
            Rectangle{
                width: drawerFlickable.width
                height: 2
                color: "black"
            }

            ItemDelegate {
                width: drawerFlickable.width
                height: drawerFlickable.width/3
                Row {
                    height: parent.height
                    width: parent.width
                    ToolSeparator {
                        width: 10
                    }
                    Image {
                        id: shoplist
                        anchors.verticalCenter: parent.verticalCenter
                        source: "qrc:/menu_icons/icons/shopping-cart.png"
                        height: parent.height*2/3
                        width: height

                    }
                    ToolSeparator {
                        width: 20
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        wrapMode: Text.Wrap
                        font.pixelSize: parent.width/12
                        text: qsTr("<b>Shopping List</b>")
                    }
                }
                onClicked: {
                    stackView.push("ShopList.qml")
                    titleLabel.text = "Shopping List"

                    drawer.close()
                    swipeView.currentIndex = 0;
                    productPage.list.currentIndex = 0
                }
            }

            ItemDelegate {
                width: drawerFlickable.width
                height: drawerFlickable.width/3
                Row {
                    height: parent.height
                    width: parent.width
                    ToolSeparator {
                        width: 10
                    }
                    Image {
                        id: settings_i
                        anchors.verticalCenter: parent.verticalCenter
                        source: "qrc:/menu_icons/icons/notification.png"
                        height: parent.height*2/3
                        width: height
                    }
                    ToolSeparator {
                        width: 20
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: parent.width/12
                        wrapMode: Text.Wrap
                        font.bold: true
                        text: qsTr("Notification")
                    }
                }
                onClicked: {
                    stackView.push("Settings.qml")
                    set = stackView.get(1)
                    titleLabel.text = "Notification"
                    drawer.close()
                    swipeView.currentIndex = 0;
                    productPage.list.currentIndex = 0
                }
            }

            ItemDelegate {
                width: drawerFlickable.width
                height: drawerFlickable.width/3
                Row {
                    height: parent.height
                    width: parent.width
                    ToolSeparator {
                        width: 10
                    }
                    Image {
                        id: aboutUs_i
                        anchors.verticalCenter: parent.verticalCenter
                        source: "qrc:/menu_icons/icons/author.png"
                        height: parent.height*2/3
                        width: height
                    }
                    ToolSeparator {
                        width: 20
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        wrapMode: Text.Wrap
                        font.pixelSize: parent.width/12
                        font.bold: true
                        text: qsTr("About App")
                    }
                }
                onClicked: {
                    stackView.push("AboutUs.qml")
                    titleLabel.text = "About App"
                    drawer.close()

                    swipeView.currentIndex = 0;
                    productPage.list.currentIndex = 0
                }
            }
        }
    }
    }

    SwipeView {
        id: swipeView
        onCurrentIndexChanged: currentIndex === 0 ? titleLabelek.text = "Categories" : titleLabelek.text = "Products"

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


        pushEnter: Transition {
               PropertyAnimation {
                   property: "opacity"
                   from: 0
                   to:1
                   duration: 500
               }
           }
           pushExit: Transition {
               PropertyAnimation {
                   property: "opacity"
                   from: 1
                   to:0
                   duration: 500
               }
           }
           popEnter: Transition {
               PropertyAnimation {
                   property: "opacity"
                   from: 0
                   to:1
                   duration: 500
               }
           }
           popExit: Transition {
               PropertyAnimation {
                   property: "opacity"
                   from: 1
                   to:0
                   duration: 500
               }
           }
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

    property var amountCategories : 0

    function refreshPages() {
        console.log("Found: " + ThingspeakData.amountCategories + " categories");
        amountCategories = 0;
        categoryPage.grid.children = "";
        productPage.listModel.clear();
        for(var i=0 ; i<ThingspeakData.amountCategories ; i++){
            var category = ThingspeakData.groupModels[i].category;
            console.log(category);
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
//    function delay_2(delayTime, cb) {
//        timerek.interval = delayTime;
//        timerek.repeat = false;
//        timerek.triggered.connect(cb);
//        timerek.start();
//    }
//    Timer {
//        id: timerek
//    }
}

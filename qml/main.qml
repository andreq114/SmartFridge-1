import QtQuick 2.12
import QtQuick.Controls 2.5

import CppTypes.Product 1.0

ApplicationWindow {
    id: window
    width: 500
    height: 700
    visible: true
    title: qsTr("Smart Fridge")

    IntroPage{
        id: intro
    }


    MainPage{
        id: mainPage

    }

    StackView {
        id: mainStack
        initialItem: intro
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
        "Near Expire Date"];

    property var amountCategories : 0


    function refreshPages() {
        console.log("Found: " + ManagerQML.amountCategories + " categories");
        amountCategories = 0;
        mainPage.categoryPage.grid.children = "";
        var mainPageListRef = mainPage.productPage.listModel;
        mainPageListRef.clear();

        for(var i=0 ; i<ManagerQML.amountCategories ; i++){
            var category = ManagerQML.groupModels[i].category;
            console.log(category);
            switch(category) {
            case Product.Dairy :
                createBtnCategory("qrc:/icons/icons/dairy-products.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/dairy-products.png" , name: names[0], category: category});
                amountCategories++;
                break;
            case Product.Drinks :
                createBtnCategory("qrc:/icons/icons/soft-drink.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/soft-drink.png" , name: names[1], category: category});
                amountCategories++;
                break;
            case Product.Alcohols :
                createBtnCategory("qrc:/icons/icons/glass.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/glass.png" , name: names[2], category: category});
                amountCategories++;
                break;
            case Product.Sauces :
                createBtnCategory("qrc:/icons/icons/sauces.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/sauces.png" , name: names[3], category: category});
                amountCategories++;
                break;
            case Product.Sweets :
                createBtnCategory("qrc:/icons/icons/sweets.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/sweets.png" , name: names[4], category: category});
                amountCategories++;
                break;
            case Product.Fishes :
                createBtnCategory("qrc:/icons/icons/fish.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/fish.png" , name: names[5], category: category});
                amountCategories++;
                break;
            case Product.Meat :
                createBtnCategory("qrc:/icons/icons/meat.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/meat.png" , name: names[6], category: category});
                amountCategories++;
                break;
            case Product.Frozen :
                createBtnCategory("qrc:/icons/icons/frozen-goods.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/frozen-goods.png" , name: names[7], category: category});
                amountCategories++;
                break;
            case Product.Plants :
                createBtnCategory("qrc:/icons/icons/healthy-food.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/healthy-food.png" , name: names[8], category: category});
                amountCategories++;
                break;
            case Product.EndOfExpiry :
                createBtnCategory("qrc:/icons/icons/hourglass.png");
                mainPageListRef.append({indeks: amountCategories,  iconSourc: "qrc:/icons/icons/hourglass.png" , name: names[9], category: category});
                amountCategories++;
                break;
            default :
                console.log("Unknown a category");
            }
        }
    }

    function buttonClicked(btnid) {
        mainPage.swipeView.setCurrentIndex(1)
        mainPage.productPage.list.currentIndex = btnid
    }

    function createBtnCategory(path) {
        var component = Qt.createComponent("CategoryBtn.qml");
        if (component.status === Component.Ready) {
            var catPage = mainPage.categoryPage.grid
            var button = component.createObject(catPage,
                                                {figure:  path
                                                    , width: (catPage.width-catPage.leftPadding - catPage.rightPadding - 2*catPage.spacing)/3
                                                    , height: (catPage.width-catPage.leftPadding - catPage.rightPadding - 2*catPage.spacing)/3
                                                    , btnid: amountCategories});
            button.clicked.connect(buttonClicked)
        }
    }

    Connections {
        target: ManagerQML
        onGroupProductsChanged: refreshPages();
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.0


import com.mycompany.qmldata 1.0
import com.mycompany.productsTableModel 1.0

Page {
    anchors.fill: parent
    id: window
    property var set
    property alias titleLabel: titleLabel
    property alias categoryPage: categoryPage
    property alias productPage: productPage
    property alias swipeView: swipeView

    header: ToolBar {
        id: mainToolBar
        contentHeight: toolButton.implicitHeight
        contentWidth: window.width

        Material.background: "#3C3C3C"
        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: toolButton

                implicitHeight: (parent.height*3)/4
                implicitWidth: implicitHeight
                icon.color: "transparent"
                icon.source: stackView.depth > 1 ? "qrc:/menu_icons/icons/return-arrow.png" : "qrc:/menu_icons/icons/menu.png"
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                onClicked: {
                    if(stackView.currentItem === set)
                        ManagerQML.refreshEndExpiryModel()
                    if (stackView.depth > 1) {
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
                font.pixelSize: 25
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
                    ManagerQML.clearNotify();
                    drawer.close()
                    //swipeView.currentIndex = 0;
                    //productPage.list.currentIndex = 0
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
                    //swipeView.currentIndex = 0;
                    //productPage.list.currentIndex = 0
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
                        id: aboutApp
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
                    stackView.push("AboutApp.qml")
                    titleLabel.text = "About App"
                    drawer.close()

                    //swipeView.currentIndex = 0;
                    //productPage.list.currentIndex = 0
                }
            }
        }
    }
    }

    SwipeView {
        id: swipeView
        onCurrentIndexChanged: currentIndex === 0 ? titleLabel.text = "Categories" : titleLabel.text = "Products"
        currentIndex: amountCategories === 0 ? 0 : currentIndex
        interactive: amountCategories === 0 ? false : true

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

    function delay_2(delayTime, cb) {
        timerek.interval = delayTime;
        timerek.repeat = false;
        timerek.triggered.connect(cb);
        timerek.start();
    }
    Timer {
        id: timerek
    }
}

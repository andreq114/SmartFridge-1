import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    width: 450
    height: 680
    visible: true
    title: qsTr("Lodóweczka")



    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"

            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {


                id: titleLabel
                text: swipeView.currentIndex == 0 ? "Categories" : "Products"




            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.5
        height: window.height
        Column {
            anchors.fill: parent
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







}

import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Tabs")
    header : TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Categorys")
        }
        TabButton {
            text: qsTr("Products")
        }
    }
    SwipeView {
        id: swipeView

        currentIndex: tabBar.currentIndex

        CategorysPage {
        }

        ProductsPage {
        }
    }

    StackView {
        id: stackView
        initialItem: swipeView
        anchors.fill: parent
    }







}

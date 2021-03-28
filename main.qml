import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    width: 1000
    height: 200
    visible: true
    title: qsTr("Smart Fridge")


    IntroPage{
        id: intro
    }


    MainPage{
        id: mainPagek
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
}

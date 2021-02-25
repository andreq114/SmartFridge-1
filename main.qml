import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    width: 450
    height: 1000
    visible: true
    title: qsTr("Lodóweczka")


//    IntroPage{
//        id: intro
//    }


    MainPage{
        id: mainPagek
    }


    StackView {
        id: mainStack
  //      initialItem: intro
        anchors.fill: parent


    }





}

import QtQuick 2.12

import QtQuick.Controls 2.5

Page{
    anchors.fill: parent
    Rectangle{
        height: (parent.height*2)/3
        width: (parent.width*3)/4
        color: "transparent"
        anchors.centerIn: parent
        Column {
            anchors.fill: parent
            Image {
                id: logoKI
                width: parent.width/2
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/menu_icons/icons/logo_KI.png"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignJustify
                width: parent.width-40
                height: width
                topPadding: 30

                text: "This application is a part of Smart Fridge system created for thesis. We can check here products which we have already in fridge or read shopping list created in second part of system including control system."
            }
        }

    }
}

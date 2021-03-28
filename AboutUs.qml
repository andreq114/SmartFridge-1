import QtQuick 2.12

import QtQuick.Controls 2.5

Page{
    Rectangle{
        id: aboutUsRect
        width: (parent.width*3)/4
        height: (parent.height*3)/4
        color: "transparent"
        anchors.centerIn: parent
        Flickable{
            id: aboutUsFlickable
            anchors.fill: parent
            contentWidth: aboutUsColumn.width    // The important part
            contentHeight: aboutUsColumn.height  // Same
            boundsBehavior: Flickable.StopAtBounds
            clip: true


            Column {
                id: aboutUsColumn

                Image {
                    id: logoKI
                    width: aboutUsFlickable.width/2
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/menu_icons/icons/logo_KI.png"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignJustify
                    width: aboutUsFlickable.width
                    height: width
                    topPadding: 30
                    font.pixelSize: aboutUsFlickable.width/20
                    text: "This application is a part of Smart Fridge system created for thesis. We can check here products which we have already in fridge or read shopping list created in second part of system including control system."
                }
            }

        }
    }
}

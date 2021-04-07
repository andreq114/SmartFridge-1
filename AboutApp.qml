import QtQuick 2.12

import QtQuick.Controls 2.5

Page{
    Rectangle{
        id: aboutAppRect
        width: (parent.width*3)/4
        height: (parent.height*3)/4
        color: "transparent"
        anchors.centerIn: parent
        Flickable{
            id: aboutAppFlickable
            anchors.fill: parent
            contentWidth: aboutAppColumn.width
            contentHeight: aboutAppColumn.height
            boundsBehavior: Flickable.StopAtBounds
            clip: true


            Column {
                id: aboutAppColumn

                Image {
                    id: logoKI
                    width: aboutAppFlickable.width/2
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/icons/icons/KI_LOGO.jpg"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignJustify
                    width: aboutAppFlickable.width
                    height: width
                    topPadding: 30
                    font.pixelSize: aboutAppFlickable.width/20
                    text: "This application is a part of Smart Fridge system created for thesis. We can check here products which we have already in fridge or read shopping list created in second part of system including control system."
                }
            }

        }
    }
}

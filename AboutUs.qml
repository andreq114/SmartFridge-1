import QtQuick 2.12

import QtQuick.Controls 2.5

Page{
    anchors.fill: parent

    Text {
        anchors.centerIn: parent
        wrapMode: Text.Wrap
        width: parent.width
        leftPadding: 10
        rightPadding: 10
        text: "This application was created by Kamil Wielgosz and Andrzej Przybyło\n as a part of Smart Fridge system which will conquere the market \u2665 "
    }
}

import QtQuick 2.12
//import TableModel 0.1
import QtQuick.Controls 2.5

Page{
    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                    //stackView.clear()
                    tabBar.visible = true

                } else {

                }
            }
        }

        Label {
            text: "Wóda i piwerka"
            anchors.centerIn: parent
        }
    }
    Column {

        Text {
            text: "Piwko"

        }
    }

}

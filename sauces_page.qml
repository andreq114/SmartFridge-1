import QtQuick 2.12
import TableModel 0.1
import QtQuick.Controls 2.5

Page{
    anchors.fill: parent
    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: "u25C0"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                    //stackView.clear()
                    tabBar.visible = true

                } else {
                    //drawer.open()
                }
            }
        }

        Label {
            text: "Sosiki"
            anchors.centerIn: parent
        }
    }
    Rectangle{
        width: 400
        height: 400
        anchors.fill: center
        Text {
            anchors.fill: center
            text: "<a href='https://www.youtube.com/watch?v=To7ZFqKDnng'>Sosik alkaida</a>"
            onLinkActivated: Qt.openUrlExternally(link)

            MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
                    cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
        }

        GridView {
            id: gridView
            x: 330
            y: 93
            width: 140
            height: 140
            delegate: Item {
                x: 5
                height: 50
                Column {
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        x: 5
                        text: name
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    spacing: 5
                }
            }
            cellHeight: 70
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
            cellWidth: 70
        }
    }


}



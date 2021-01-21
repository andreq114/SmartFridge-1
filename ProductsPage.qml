import QtQuick 2.12
import TableModel 0.1
import QtQuick.Controls 2.5
//import QtQml 2.15

Page{
    TableView {
        anchors.fill: parent
        columnSpacing: 5
        rowSpacing: 5
        clip: true

        model: TableModel {

        }

        delegate : Image {
            id: glass_icon
            width: 75
            height: 75

            source: "qrc:/icons/icons/glass.png"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    glass_animation.start()


                }

                SequentialAnimation {
                    id: glass_animation

                    PropertyAnimation {
                        target: glass_icon
                        property: "opacity"

                        from: 1
                        to: 0.5
                        duration: 250
                    }

                    PropertyAnimation {
                        target: glass_icon
                        property: "opacity"

                        from: 0.5
                        to: 1
                        duration: 250
                    }
                }
            }
        }
    }

}


import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.2

Page {
    width: 600
    height: 400
    title: qsTr("Categorys of products")
    ScrollView {
        anchors.fill: parent
        Column {
            spacing: 10

            //Button
            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/glass.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/fish.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/dairy-products.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/frozen-goods.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/healthy-food.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15

                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/meat.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/plastic.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/sauces.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/soft-drink.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }

            RoundButton{
                height: 100
                width: 100
                radius: 15
                visible: false
                background: Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: "white"  // I update background color by this
                }

                Image {
                    height: 75
                    width: 75
                    anchors.centerIn: parent
                    source: "qrc:/icons/icons/sweets.png"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "red"
                    opacity: parent.pressed ? 0.5 : 0
                }
            }
        }


    }

}


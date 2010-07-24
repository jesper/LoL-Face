import Qt 4.7

Dialog {
    id: configureDialog
    titletext: "Configure Stuff"

    Rectangle {
        id: widgets
        width: 600
        height: 300
        x: contentsX + 10
        y: contentsY + 20
        color: "transparent"

        Text{
            id: triggerLabel
            text: "Trigger to add:"
            font.pointSize: 14
            color: "white"

            TextInput {
                id: triggerInput
                x: triggerLabel.width + 10
                y: 0
                font.pointSize: parent.font.pointSize
                width: 80

                Rectangle {
                    color: "white"
                    anchors.fill: parent
                    z: parent.z - 1
                }
            }

            Image {
                id:addTriggerImage
                source: "/images/add.svg"
                sourceSize.width: 50
                sourceSize.height: 50
                width: 50
                height: 50
                x: triggerInput.x + triggerInput.width

                MouseArea {
                    id: addTriggerImageMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
                states: [
                    State {
                        name: "Hovered"; when: addTriggerImageMouseArea.containsMouse
                        PropertyChanges { target: addTriggerImage; sourceSize.width: 72; sourceSize.height:72; scale: 1.2;}
                    }
                ]


                transitions: [
                    Transition {
                        NumberAnimation { properties: "scale"; duration: 1000; easing.type: Easing.OutElastic }
                    }
                ]
            }
        }
        Text {
            y: 100
            text: "QML ROX MY SOX"
        }
    }
}

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
                sourceSize.width: 25
                sourceSize.height: 25
                width: 25
                height: 25
                x: triggerInput.x + triggerInput.width + 5

                MouseArea {
                    id: addTriggerImageMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        parent.scale = 1.5
                        cplusplus.addTrigger(triggerInput.text)
                        triggerInput.text = ""
                    }

                    onReleased: {
                        parent.scale = 1
                    }
                }

                states: [
                    State {
                        name: "Hovered"; when: addTriggerImageMouseArea.containsMouse
                        PropertyChanges { target: addTriggerImage; sourceSize.width: 30; sourceSize.height:30; scale: 1.2;}
                    }
                ]


                transitions: [
                    Transition {
                        NumberAnimation { properties: "scale"; duration: 200; easing.type: Easing.InOutQuad }
                    }
                ]
            }
        }

        ListView {
            y: triggerInput.height + 10
            width: parent.width
            height: 200

            model: triggerModel
            delegate: triggerDelegate

            Rectangle {
                anchors.fill: parent
                color: "white"
                z: parent.z - 1
            }
        }


        Component {
            id: triggerDelegate;
            Text {
                color: "green"
                text: display + "!"
            }

        }
    }
}

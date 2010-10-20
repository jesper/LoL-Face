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


        }


        Component {
            id: triggerDelegate;

            Rectangle {
                color: "transparent"
                width: triggerDelegateBox.width + 5
                height: triggerDelegateBox.height + 5


                Rectangle {
                    id: triggerDelegateBox
                    color: "blue"
                    width: triggerDelegateText.width + 5
                    height: triggerDelegateText.height + 5
                    radius: 3
                    anchors.margins:4
                    Text {
                        id: triggerDelegateText
                        color: "white"
                        font.pointSize: 12
                        text: display
                    }

                    Image {
                        id: triggerDelegateRemoveImage
                        x: triggerDelegateText.width + 10
                        source: "/images/remove.svg"
                        sourceSize.width: 20
                        sourceSize.height: 20
                        width: 20
                        height: 20

                        MouseArea {

                            id: triggerDelegateRemoveMouseArea
                            hoverEnabled: true

                            anchors.fill: parent

                            onPressed: {
                                parent.scale = 1.5
                                console.log("Deleting:" + triggerDelegateText.text)
                                cplusplus.removeTrigger(triggerDelegateText.text)
                            }

                            onReleased: {
                                parent.scale = 1
                            }


                            states: [
                                State {
                                    name: "Hovered"; when: triggerDelegateRemoveMouseArea.containsMouse
                                    PropertyChanges { target: triggerDelegateRemoveImage; sourceSize.width: 24; sourceSize.height:24; scale: 1.2;}
                                }
                            ]


                            transitions: [
                                Transition {
                                    NumberAnimation { properties: "scale"; duration: 200; easing.type: Easing.InOutQuad }
                                }
                            ]
                        }
                    }

                }
            }
        }
    }
}

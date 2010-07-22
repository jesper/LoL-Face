import Qt 4.7

Rectangle {
    id: dialog
    property bool shown: false
    color: "black"
    opacity: 0
    width: 640
    height: 480

    z: 10

    property alias titletext: titleText.text
    property alias bodytext: bodyText.text
    property alias contentsX: bodyText.mappedX
    property alias contentsY: bodyText.mappedY


    Rectangle {
        id: contentsbox
        x: 15
        y: 15
        width: parent.width - 30
        height: parent.height - 30
        color: "black"

        Text {
            id: titleText
            x: (parent.width - titleText.width) /2
            y: 10
            color: "white"
            font.pointSize: 20
            text: "TITLE HERE"
        }

        Text {
            id: bodyText
            height: parent.height
            width: parent.width
            x: 0
            y: titleText.height + 15
            property int mappedX : parent.x + x
            property int mappedY : parent.y + y
            color: "white"
            wrapMode: Text.WordWrap
            font.pointSize: 11
            text: "CONTENT HERE"
        }

        Rectangle {
            id: closeButton
            width: 70
            height: 25
            color: "red"
            y: parent.height - height
            x: (parent.width - width) / 2
            Text {
                id: closeButtonText
                x: (parent.width - width) / 2
                text: "Close"
                font.pointSize: 16
            }

            MouseArea {
                id: closeButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    dialog.shown = false;
                }

            }
            states: [
                State {
                    name: "Hovered"; when: closeButtonMouseArea.containsMouse
                    PropertyChanges { target: closeButton; scale: 1.2 }
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation { properties: "scale"; duration: 1000; easing.type: Easing.OutElastic }
                }
            ]


        }
    }

}

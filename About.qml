import Qt 4.7

Rectangle {
    id: aboutbox
    property bool shown: false
    color: "black"
    opacity: 0
    width: 640
    height: 480

    z: 10

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
            color: "white"
            font.pointSize: 20
            text: "About LoL-Face"
        }

        Text {
            id: bodyText
            height: contentsbox.height
            width: contentsbox.width
            y: titleText.height + 10
            color: "white"
            wrapMode: Text.WordWrap
            font.pointSize: 12
            text: "
LoL-Face will take a snapshot of you and your desktop each time you type \"lol\", \":D\", etc.

To view an image, click on its thumbnail.

To view the desktop, click the \"desktop\" icon in the top left corner when in image viewing mode.

To configure the words which trigger image captures, click the \"configure\" icon in the top right corner.

Clicking the normal close button on the window will simply hide LoL-Face. If LoL-Face is hidden, you can show it again by clicking the system-tray icon.

To Quit the application, click the large red \"quit\" icon in the top right corner.

Author: Jesper Thomschutz <jesper@jespersaur.com>
Tango Icons: Jakub Steiner & Andreas Nilsson <www.openclipart.org>
                    "
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
                    aboutbox.shown = false;
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

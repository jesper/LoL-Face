import Qt 4.7

Rectangle {
    id: wallpaper
    color: "black"
    width: 800; height: 600
    property int cell_width: 160
    property int cell_height: 120

    function getDesktopImagePath(x) {
        return x.toString().replace('.webcam.jpg', '.desktop.jpg');
    }

    states: [
        State {
            name: "AboutVisible"; when: aboutbox.shown
            PropertyChanges { target: imageGrid; enabled: false }
            PropertyChanges { target: aboutbox; opacity: 0.8}
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "opacity"; duration: 500; easing.type: Easing.InOutQuad }
        }
    ]

    About {
        id:aboutbox
        x: 100
        y: 100
    }

    Rectangle {
        id: menu
        color: "grey"
        width: parent.width
        height: 60
        z: 8

        gradient: Gradient {

            GradientStop { position: 0; color: "darkgrey" }
            GradientStop { position: 0.95; color: "grey" }
            GradientStop { position: 1.1; color: "darkgrey" }

        }

        Image {
            id: aboutButton
            source: "/images/about.svg"
            sourceSize.width: 60
            sourceSize.height: 60
            width: 60
            height: 60
            x: parent.width-width-quitButton.width
            y: 0
            z: 9

            MouseArea {
                id: aboutButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    aboutbox.shown = !aboutbox.shown;
                }

            }
            states: [
                State {
                    name: "Hovered"; when: aboutButtonMouseArea.containsMouse
                    PropertyChanges { target: aboutButton; sourceSize.width: 72; sourceSize.height:72; scale: 1.2;}
                }
            ]


            transitions: [
                Transition {
                    NumberAnimation { properties: "scale"; duration: 1000; easing.type: Easing.OutElastic }
                }
            ]

        }

        Image {
            id: quitButton
            source: "/images/quit.svg"
            sourceSize.width: 60
            sourceSize.height: 60
            width: 60
            height: 60
            x: parent.width-width
            y: 0
            z: 9

            MouseArea {
                id: quitButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    cplusplus.quit();
                }

            }
            states: [
                State {
                    name: "Hovered"; when: quitButtonMouseArea.containsMouse
                    PropertyChanges { target: quitButton; sourceSize.width: 72; sourceSize.height:72; scale: 1.2;}
                }
            ]


            transitions: [
                Transition {
                    NumberAnimation { properties: "scale"; duration: 1000; easing.type: Easing.OutElastic }
                }
            ]

        }

        Image {
            id: backButtonElement
            source: "/images/back.svg"
            sourceSize.width: 60
            sourceSize.height: 60
            width: 60
            height: 60
            fillMode: Image.PreserveAspectFit
            x: 0
            y: height * -1
            z: 9
            property bool clicked: false

            MouseArea {
                id: backButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    imageGrid.currentImage.fullscreen = false;
                    desktopElement.fullscreen = false;
                    desktopElement.zoom = false;
                    parent.state = ""
                }
                onEntered: {
                    if (parent.state == "Visible") parent.state = "Hovered";
                }
                onExited: {
                    if (parent.state == "Hovered") parent.state = "Visible";
                }
            }

            states: [
                State {
                    name: "Visible"; when: imageGrid.currentImage.fullscreen
                    PropertyChanges { target: backButtonElement; y: 0; clicked: true}
                },
                State {
                    name: "Hovered";
                    PropertyChanges { target: backButtonElement; y:0; sourceSize.width: 72; sourceSize.height: 72; scale: 1.2}
                }
            ]


            transitions: [

                Transition {
                    NumberAnimation { property: "y"; duration:300; easing.type: Easing.InOutQuad}
                    NumberAnimation { property: "scale"; duration:1000; easing.type: Easing.OutElastic}
                }

            ]
        }


        Image {
            id: faceButtonElement
            source: "/images/happy.svg"
            sourceSize.height: 60
            sourceSize.width: 60
            height: 60
            width: 60

            fillMode: Image.PreserveAspectFit
            x: backButtonElement.width
            y: height * -1
            z: 9


            MouseArea {
                id: faceButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    desktopElement.fullscreen = false;
                    parent.state = "";
                }
                onEntered: {
                    if (parent.state == "Visible") parent.state = "Hovered";
                }
                onExited: {
                    if (parent.state == "Hovered") parent.state = "Visible";
                }
            }
            states: [
                State {
                    name: "Visible"; when: desktopElement.fullscreen
                    PropertyChanges { target: faceButtonElement; y: 0;}
                },
                State {
                    name: "Hovered";
                    PropertyChanges { target: faceButtonElement; y:0; sourceSize.width: 72; sourceSize.height: 72; scale: 1.2}
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation { property: "y"; duration:300; easing.type: Easing.InOutQuad}
                    NumberAnimation { property: "scale"; duration:1000; easing.type: Easing.OutElastic}
                }
            ]
        }

        Image {
            id: desktopButtonElement
            source: "/images/desktop.svg"
            sourceSize.width: 60
            sourceSize.height: 60
            height: 60
            fillMode: Image.PreserveAspectFit
            x: backButtonElement.width
            y: desktopButtonElement.width * -1
            z: 9

            MouseArea {
                id: desktopButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    desktopElement.fullscreen = true;
                    parent.state = "";
                }

                onEntered: {
                    if (parent.state == "Visible") parent.state = "Hovered";
                }
                onExited: {
                    if (parent.state == "Hovered") parent.state = "Visible";
                }
            }

            states: [
                State {
                    name: "Visible"; when: imageGrid.currentImage.fullscreen && !desktopElement.fullscreen
                    PropertyChanges { target: desktopButtonElement; y: 0;}
                },
                State {
                    name: "Hovered";
                    PropertyChanges { target: desktopButtonElement; y:0; sourceSize.width: 72; sourceSize.height: 72; scale: 1.2}
                }

            ]

            transitions: [
                Transition {
                    NumberAnimation { property: "y"; duration:300; easing.type: Easing.InOutQuad}
                    NumberAnimation { property: "scale"; duration:1000; easing.type: Easing.OutElastic}
                }
            ]

        }
    }
    Image {
        id: desktopElement
        property bool fullscreen: false
        property bool zoom: false

        opacity: 0
        z: 3
        width: parent.width
        height: parent.height - menu.height
        y: menu.height

        MouseArea {
            id: desktopElementMouseArea
            anchors.fill: parent
            onClicked: {
                desktopElement.zoom = !desktopElement.zoom;
            }
        }

        states: [
            State {
                name: "Invisible"; when: !desktopElement.fullscreen
                PropertyChanges { target: desktopElement; opacity: 0;}
            },
            State {
                name: "Visible"; when: desktopElement.fullscreen && !desktopElement.zoom
                PropertyChanges { target: desktopElement; opacity: 1; }
            },
            State {
                name: "Zoomed"; when: desktopElement.fullscreen && desktopElement.zoom
                PropertyChanges { target: desktopElement; opacity: 1; width: sourceSize.width; height: sourceSize.height }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { properties: "width, height, opacity, y"; duration: 500; easing.type: Easing.InOutQuad}
            }
        ]
    }

    Component {
        id: imageDelegate


        Image {
            id: imageElement
            property bool fullscreen: false

            sourceSize.width: cell_width
            sourceSize.height: cell_height

            scale: 0
            source: display
            width: imageGrid.cellWidth - 10; height: imageGrid.cellHeight - 20

            // Have to add this, since otherwise we get some pretty strange behaviour each time we add an image
            // while in full screen mode.
            GridView.onAdd: {
                imageGrid.currentImage.fullscreen = false;
                desktopElement.fullscreen = false;
            }

            MouseArea {
                id: imageMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: { imageElement.fullscreen = true; imageElement.z = 3}
            }

            states: [
                State {
                    name: "Show"; when: imageElement.status == Image.Ready && !imageMouseArea.containsMouse && !imageElement.fullscreen
                    PropertyChanges { target: imageElement; scale: 1; z: 1}
                },
                State {
                    name: "FullScreen"; when: imageElement.fullscreen
                    PropertyChanges { target: imageElement; sourceSize.height: imageElement.height; sourceSize.width: imageGrid.width; x: imageGrid.contentX; y: imageGrid.contentY; width: imageGrid.width; height: imageGrid.height; scale: 1}
                    PropertyChanges { target: imageGrid; currentImage:imageElement; interactive:false; }
                    PropertyChanges { target: desktopElement; source: getDesktopImagePath(imageGrid.currentImage.source); }
                },
                State {
                    name: "Hovered"; when: imageMouseArea.containsMouse
                    PropertyChanges { target: imageElement; scale: 1.4; z: 2 }
                }
            ]


            transitions: [
                Transition {
                    to: "Show"
                    NumberAnimation { properties: "x, y, z, width, height, scale"; duration: 250; easing.type: Easing.InOutQuad}
                },
                Transition {
                    from: "Show"; to: "Hovered"
                    NumberAnimation { properties: "z, scale"; duration: 1050; easing.type: Easing.OutElastic }
                },
                Transition {
                    from: "Hovered"; to: "FullScreen"
                    NumberAnimation { properties: "x, y, width, height"; duration: 350; easing.type: Easing.InOutBack}
                },
                Transition {
                    from: "FullScreen"; to: "Hovered"
                    NumberAnimation { properties: "z, x, y, width, height"; duration: 500; easing.type: Easing.OutBack }
                }
            ]
        }
    }


    GridView {
        id: imageGrid
        property Image currentImage
        highlightFollowsCurrentItem: false

        width: parent.width
        height: parent.height - menu.height
        cellWidth: cell_width
        cellHeight: cell_height
        y: menu.height

        model: imageModel
        delegate: imageDelegate
    }


}


import Qt 4.7

Rectangle {
    color: "black"
    opacity: 0.8
    width: 640
    height: 480

    z: 10

    Rectangle {
        id: contents
        x: 15
        y: 15
        width: parent.width - 30
        height: parent.height - 30
        color: "black"
    }
}


import QtQuick 2.0
//import QtGraphicalEffects 1.0

Item {
    width: buttonImage.sourceSize.width
    height: buttonImage.sourceSize.height

    property alias source: buttonImage.source
    property bool active: false

    Image {
        id: buttonImage
        smooth: true
//        visible: !active
    }

    Rectangle {
        anchors.fill: buttonImage
        color: "#14abff"
        opacity: 0.6
        radius: 8
        visible: active
    }

    // BrightnessContrast {
    //     anchors.fill: buttonImage
    //     source: buttonImage
    //     brightness: 0.5
    //     contrast: 0.5
    //     visible: active
    // }
}

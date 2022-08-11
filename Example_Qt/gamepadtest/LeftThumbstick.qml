
import QtQuick 2.0
import QtGamepad 1.0

ButtonImage {

    property Gamepad gamepad

    id: leftStickButton
    source: "qrc:/xboxControllerLeftThumbstick.png"
    active: gamepad.buttonL3

    JoystickViewer {
        id: leftJoystick
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: parent.width * (3 / 153)
        width: parent.width * (140 / 153)
        xAxisValue: gamepad.axisLeftX
        yAxisValue: gamepad.axisLeftY
        height: width
    }
    Text{
        id:text1
       anchors.fill: parent
       text: leftJoystick.xAxisValue
       font.pixelSize: 30
       anchors.rightMargin: 22
       anchors.leftMargin: 64
       anchors.topMargin: 85
       anchors.bottomMargin: 8


    }
}

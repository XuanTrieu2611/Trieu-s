import QtQuick 2.15
import QtQuick.Window 2.15
import QtGamepad 1.0
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Text{
        id:text1
        height:50
        width:200
        x:342
        y:125
        text:gamepad.axisLeftX

    }


    LeftThumbstick {
        id: leftThumbstick
        x: 39
        y: 14
        height: 200
        width: 200
        gamepad: gamepad

    }
    Connections {
        target: GamepadManager
        function onGamepadConnected() {gamepad.deviceId = deviceId}
    }

    Gamepad {
        id: gamepad
        deviceId: GamepadManager.connectedGamepads.length > 0 ? GamepadManager.connectedGamepads[0] : -1
    }
}

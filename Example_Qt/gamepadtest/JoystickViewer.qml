
import QtQuick 2.0

Item {
    width: 100
    height: 100

    property real xAxisValue: 0
    property real yAxisValue: 0

    onXAxisValueChanged: {
        joystickCanvas.requestPaint();
    }
    onYAxisValueChanged: {
        joystickCanvas.requestPaint()
    }

    Canvas {
        id: joystickCanvas
        anchors.fill: parent

        onPaint: {
            var context = joystickCanvas.getContext("2d")
            context.clearRect(0, 0, width, height);
            var targetX = (xAxisValue + 1) / 2 * width;
            var targetY = (yAxisValue + 1) / 2 * height;
            context.fillStyle = "red";
            context.beginPath();
            context.arc(targetX, targetY, 5, 0, 2 * Math.PI, false);
            context.closePath();
            context.fill();
        }
    }

}

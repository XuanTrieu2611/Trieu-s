import "../../Misc"

import QtQuick 2.15
import QtGraphicalEffects 1.0
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
    property double minorTickmarkHeight:  14 / 90 * outerRadius
    property double tickmarkHeight:  20 / 90 * outerRadius

    id: style
    minimumValueAngle: -126
    maximumValueAngle: 126
    tickmarkStepSize: 500
    labelStepSize: 500
    minorTickmarkCount: 4

    labelInset: 36 / 90 * outerRadius
    tickmarkInset: 6 / 90 * outerRadius
    minorTickmarkInset: 6 / 90 * outerRadius

    tickmark: Rectangle {
        color: "#ffffff"
        width: 3 / 90 * outerRadius
        height: style.tickmarkHeight
        radius: 3 / 90 * outerRadius
        antialiasing: true
    }

    minorTickmark: Rectangle {
        color: "#ffffff"
        width: 1.5 / 90 * outerRadius
        height:style.minorTickmarkHeight
        radius: 3 / 90 * outerRadius
        antialiasing: true
    }

    tickmarkLabel: Text {
        font.family: "Century Gothic"
        font.pixelSize: Math.max(6, outerRadius * 0.15)
        text: styleData.value / 100
        antialiasing: true
        color: "#ffffff"
        font.weight: Font.Black
    }

    foreground: Item {
        anchors.fill: parent
        CustomForeground {
            anchors.centerIn: parent
            radius: 10 / 90 * outerRadius
        }
    }

    needle: CustomNeedle {
        width: 8 / 90 * outerRadius
        height: 65 / 90 * outerRadius
    }

    background: Rectangle {
        id: background
        width: 2 * outerRadius
        height: 2 * outerRadius
        radius: outerRadius
        color: "#181818"

        CustomCanvas {
            anchors.fill: parent
            onPaint: {
                if(context)
                {
                    context.reset()
                    context.lineWidth = 7 / 90 * outerRadius
                    context.beginPath()
                    context.arc(outerRadius,
                            outerRadius,
                            outerRadius - tickmarkInset - 0.5 * style.minorTickmarkHeight,
                            (valueToAngle(2400) - 90) *  Math.PI / 180.0,
                            (valueToAngle(3500) - 90) *  Math.PI / 180.0)
                    context.strokeStyle = "red"
                    context.stroke()
                }
            }
        }

        Text {
            x: 0
            y: 0.65 * outerRadius
            width: 2 * outerRadius
            text: "x1000 RPM"
            color: "#ffffff"
            font.family: "Century Gothic"
            font.pixelSize: Math.max(6, outerRadius * 0.125)
            font.weight: Font.Black
            antialiasing: true
            horizontalAlignment: Text.AlignHCenter
        }
    }
}

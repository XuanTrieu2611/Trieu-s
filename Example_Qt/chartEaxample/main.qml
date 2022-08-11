import QtQuick 2.8
import QtCharts 2.2
import QtQuick.Window 2.2
import QtQuick.Controls 2.12

ApplicationWindow{
    visible: true
    width: 640
    height: 480

    Connections {
        target: dataFromCpp
        onWValueChanged: {
            if(lineSeries1.count > 20)
                lineSeries1.remove(0);
            lineSeries1.append(dataFromCpp.wValue.x, dataFromCpp.wValue.y)
            axisX.min = lineSeries1.at(0).x
            axisX.max = lineSeries1.at(lineSeries1.count-1).x
            if(lineSeries2.count > 20)
                lineSeries2.remove(0);
            lineSeries2.append(dataFromCpp.wValue.x, dataFromCpp.wValue.y+5)
        }
    }

    ChartView {
        id: chartView
        width: parent.width
        height: parent.height
        anchors.fill: parent
        animationOptions: ChartView.SeriesAnimations
        //animationEasingCurve : easing
        animationDuration: 20
        antialiasing: true
        backgroundColor: "white"

        ValueAxis {
            id: axisY1
            min: 0
            max: 100
            gridVisible: true
            color: "black"
            labelsColor: "black"
            labelFormat: "%.0f"
            titleText: "Roll(Deg)"
        }

        ValueAxis {
            id: axisX
            min: 0
            max: 200
            gridVisible: true
            color: "black"
            labelsColor: "black"
            labelFormat: "%.0f"
            tickCount: 20
            titleText: "Time(s)"
        }

        SplineSeries {
            id: lineSeries1
            width: 5
            name: "Roll"
            color: "black"
            axisX: axisX
            axisY: axisY1
        }
        SplineSeries {
            id: lineSeries2
            name: "Pitch"
            color: "green"
            axisX: axisX
            axisY: axisY1
            width: 5
        }
    }
}

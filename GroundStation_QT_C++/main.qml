import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtLocation 5.6
import QtCharts 2.3
import QtPositioning 5.6
import QtQuick.Extras 1.4
import "UI/map"
import "UI/indicator"
import "UI/indicator/PropellerGauge"
import "UI/indicator/EADI"
import "UI/indicator/SpeedGauge"

ApplicationWindow {
    id : root
    width: 1920
    height: 1080
    visible: true
    color: "white"
    title: qsTr("USV GROUND STATION")
    Connections {
        target: dataudp
        function onPlotChange(){
            if(lineSeriesAccX.count > 15)
                lineSeriesAccX.remove(0);
            lineSeriesAccX.append(dataudp.getplotAccX.x, dataudp.getplotAccX.y)
            axisXacc.min = lineSeriesAccX.at(0).x
            axisXacc.max = lineSeriesAccX.at(lineSeriesAccX.count-1).x
            if(lineSeriesAccY.count > 15)
                lineSeriesAccY.remove(0);
            lineSeriesAccY.append(dataudp.getplotAccX.x, dataudp.getplotAccY.y)

            if(lineSeries1.count > 15)
                lineSeries1.remove(0);
            lineSeries1.append(dataudp.getplotRoll.x, dataudp.getplotRoll.y)
            axisX.min = lineSeries1.at(0).x
            axisX.max = lineSeries1.at(lineSeries1.count-1).x
            if(lineSeries2.count > 15)
                lineSeries2.remove(0);
            lineSeries2.append(dataudp.getplotRoll.x, dataudp.getplotPitch.y)

            if(lineSeries3.count > 15)
                lineSeries3.remove(0);
            lineSeries3.append(dataudp.getplotDistance.x, dataudp.getplotDistance.y)
            axisX1.min = lineSeries3.at(0).x
            axisX1.max = lineSeries3.at(lineSeries3.count-1).x
            //axisY1.min = lineSeries3.at(lineSeries3.count-1).y
            rollLabel.text = dataudp.getplotRoll.y
            pitchLabel.text = dataudp.getplotPitch.y
        }
        function onRollChange(){
            electronicAttitudeDirectionIndicator.adi.roll = dataudp.udproll
            if(dataudp.roll > 10){
                statusindicatorUSV.active = true
            }else{
                statusindicatorUSV.active = false
            }
        }
        function onPitchChange(){
            electronicAttitudeDirectionIndicator.adi.pitch = dataudp.udppitch
        }
        function onYawChange(){
            electronicAttitudeDirectionIndicator.hsi.heading = dataudp.udpyaw
            electronicAttitudeDirectionIndicator.hsi.bugValue = dataudp.udpyaw
        }
        function onGpsChange(){
            textCurentLatitude.text = dataudp.gpslatitude
            textCurentLongtitude.text = dataudp.gpslongitude
            textNextLatitude.text = dataudp.nextlatitude
            textNextLongtitude.text = dataudp.nextlongitude
            textDistancetoNP.text = dataudp.distancetoNP
            textSpeed.text = dataudp.speed
            speedGaugeindicator.rpm = dataudp.speed*100
    }

        function onAccXChange(){
            textAccX.text = dataudp.accX
        }
        function onAccYChange(){
            textAccY.text = dataudp.accY
        }
        function onVoltageChange(){
            textVoltage.text = dataudp.udpvoltage
        }
        function onCurrentChange(){
            textAmpere.text = dataudp.udpcurrent
        }
        function onBatteryChange(){
            textAmpereHour.text = dataudp.udpbattery
        }
        function onPwmEngineLeftChange(){
            textLEnginePWM.text = dataudp.pwmEngineLeft
            propellerGaugeLeft.rpm = dataudp.pwmEngineLeft*(2500/100)
        }
        function onPwmEngineRightChange(){
            textREnginePWM.text = dataudp.pwmEngineRight
            propellerGaugeRight.rpm = dataudp.pwmEngineRight*(2500/100)
        }
        function onDistanceChange(){
            textDepth.text = dataudp.distance
        }
        function onConfidenceChange(){
            textConfidence.text = dataudp.confidence
        }
        function onPowerChange(){
            textPower.text = dataudp.power
        }

    }

    Item {
        id: container
        property double scaleRatio: 2.0 * Math.min(height / 1080, width / 1920)

        anchors {
            fill: parent
            margins: 0
        }

        Row {
            anchors.centerIn: parent
            spacing: 8
            scale: container.scaleRatio

            Rectangle {
                width: electronicAttitudeDirectionIndicator.width+6
                height: electronicAttitudeDirectionIndicator.height+6
                radius: 6
                color: "black"


                ElectronicAttitudeDirectionIndicator {
                    id:electronicAttitudeDirectionIndicator
                    anchors.centerIn: parent
                    scaleRatio: container.scaleRatio
                    adi.angleOfAttack: 0
                    adi.sideSlipAngle: 0
                    adi.roll: 0
                    adi.pitch: 0
                    adi.slipSkid: 0
                    adi.turnRate: 0
                    adi.dotH: 0
                    adi.dotV: 10
                    adi.fdPitch: 10
                    adi.fdRoll: 0
                    adi.dotHVisible: true
                    adi.dotVVisible: false
                    adi.fdVisible: false
                    adi.stallVisible: false
                    hsi.heading: 0
                    hsi.bugValue: 0
                }

            }
        }
        Label{
            x:835
            y: 232
            width: 100
            height:100
            text:"Roll"
            color: "white"
            font.pixelSize: 30
        }
        Label{
            id:rollLabel
            x:845
            y: 265
            width: 100
            height:100
            text:"0"
            color: "red"
            font.pixelSize: 40
            onTextChanged: rollLabel.text = dataudp.udproll
        }
        Label{
            x:1020
            y: 232
            width: 100
            height:100
            text:"Pitch"
            color: "white"
            font.pixelSize: 30
        }
        Label{
            id:pitchLabel
            x:1035
            y: 265
            width: 100
            height:100
            text:"0"
            color: "red"
            font.pixelSize: 40
        }
    }
    Rectangle{
        id:rectanGauge
        width: parent.width*0.4
        height:parent.height
        anchors.left:parent.left
        radius: 10
        border.width: 5
        border.color: "black"
        PropellerGauge{
            id: propellerGaugeLeft
            x: 0
            radius: 150
            rpm: 0
            nameEngine: "Left"

        }
        PropellerGauge{
            id: propellerGaugeRight
            anchors.left: propellerGaugeLeft.right
            anchors.leftMargin: -10
            radius: 150
            rpm : 0
            nameEngine:"Right"
        }
        Battery{
            id: battery
            value: 0.3
            x: 540
            y:110
            rotation: -90
        }


        SpeedGauge{
            id: speedGaugeindicator
            anchors.top: propellerGaugeLeft.bottom
            anchors.topMargin: -20
            x: 0
            radius: 150
            nameEngine:"Speed"
            rpm : 0
        }
        Rectangle{
            id: ractangleIndicator
            width: parent.width*2/3-50
            height: speedGaugeindicator.height - 20
           // color: "red"
            anchors.bottom: rectangleData.top
            anchors.right: parent.right
            anchors.rightMargin: 10
            radius: 10
            border.width: 3
            border.color: "black"
            Text {
                id: name
                text: qsTr("Battery")
                x:10
                y:13
                font.pixelSize: 20

            }

            TextField{
                width: 140
                height:40
                x:90
                y:6
                placeholderText: qsTr("Set Capacity")
            }
            Button{
                width: 140
                height:40
                y : 6
                x : 250
                text: "Connect Battery"
            }

            Image{
                width: 80
                height:80
                y : 60
                x : 90
                source: "qrc:/image/iconidicator/up-arrow.png"
                opacity: 0.2

            }
            Image{
                width: 80
                height:80
                y : 180
                x : 90
                source: "qrc:/image/iconidicator/down-arrow.png"
                 opacity: 0.2

            }
            Image{
                width: 80
                height:80
                y : 120
                x : 10
                source:"qrc:/image/iconidicator/left-arrow.png"
                 opacity: 0.2

            }
            Image{
                width: 80
                height:80
                y : 120
                x : 180
                source: "qrc:/image/iconidicator/arrow-right.png"
                 opacity: 0.2

            }
        }

        Rectangle{
            id: rectangleData
            anchors{
                top: speedGaugeindicator.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                leftMargin: 10
                rightMargin: 10
                topMargin: 0
                bottomMargin: 10
            }
            radius: 15
            border.width: 4
            border.color: "black"
            color: "white"
            GridLayout{
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    leftMargin: 10
                    rightMargin: 10
                    topMargin: 10
                    bottomMargin: 10
                }
                columns:4

                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "Speed (m/s)"
                        font.pixelSize: 20

                    }
                    Text {
                        id:textSpeed
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "AccelX(m²/s)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textAccX
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50

                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "AcccelY(m²/s)"
                        font.pixelSize: 20

                    }
                    Text {
                        id:textAccY
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "Power(W))"
                        font.pixelSize: 20

                    }
                    Text {
                        id:textPower
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "Voltage(V)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textVoltage
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }

                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "Ampere(A)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textAmpere
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "AmpereHour(mAh)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textAmpereHour
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }

                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "DistancetoNP(m)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textDistancetoNP
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "LEnginePWM(%)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textLEnginePWM
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "REnginePWM(%)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textREnginePWM
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "Depth(m)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textDepth
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }
                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:"white"
                    Text {

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: "Confidence(%)"
                        font.pixelSize: 20

                    }
                    Text {
                        id: textConfidence
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        text: "00.00"
                        font.pixelSize: 50
                    }

                }



            }

        }
    }

    Rectangle{
        id: rectanLigthIndicator
        width: parent.width*0.2
        height:220
        anchors.left: rectanGauge.right
        anchors.right: rectanPlot.left
        color: "white"
        radius: 10
        border.width: 5


        //ColorSpace:"black"
        StatusIndicator{
            id: statusindicatorUSV
            //color: "green"
            active: false
            width: 100
            height:100


        }
        TextField{
            id: textIp
            x: 105
            y: 10
            width: 160
            text: "192.168.1.154"
            placeholderText: "Ip Address"

        }
        TextField{
            id: textPort
            x:105
            y:55
            width: 160
            text: "5005"
            placeholderText:"Port"

        }
        RoundButton{
            radius:10
            x: 270
            y:35
            width: 105
            height: 40
            text: "Connect"
            onClicked: {

                dataudp.setIp(textIp.text)
                dataudp.setPort(textPort.text)
                dataudp.start()

            }

        }
        Switch {
            id: switchAutoHandle
            x: 10
            y: 100
            text: qsTr("Joystick")
            position: 0
            onClicked: {
                if(switchAutoHandle.position === 1){
                    //console.log(switchAutoHandle.position)
                    switchAutoHandle.text = "Auto Mode"
                    autoModeImage.visible = true
                    joystickImage.visible = false
                    dataudp.autoModeOn()
                }
                if(switchAutoHandle.position === 0){
                    //console.log(switchAutoHandle.position)
                    switchAutoHandle.text = "Joystick"
                    joystickImage.visible = true
                    autoModeImage.visible = false
                    dataudp.joystickModeOn()
                }
            }
        }
        Image {
            id: joystickImage
            source: "qrc:/image/iconidicator/gamepadmode.png"
            width: 90
            height: 90
            x: 30
            y: 125
            visible: true
        }
        Image {
            id: autoModeImage
            source: "qrc:/image/iconidicator/automode1.png"
            width: 90
            height: 90
            x: 30
            y: 125
            visible: false
        }
        Switch {
            id: swithHeadlight
            x: 200
            y: 100
            text: qsTr("HeadLight Off")
            position: 0
            onClicked: {
                if(swithHeadlight.position === 1){
                    console.log(swithHeadlight.position)
                    swithHeadlight.text = "HeadLight On"
                    headLightImage.opacity = 1
                    dataudp.udpHeadLightOn(true)

                }
                if(swithHeadlight.position === 0){
                    console.log(swithHeadlight.position)
                    swithHeadlight.text = "HeadLight Off"
                    headLightImage.opacity = 0.2
                    dataudp.udpHeadLightOn(false)
                }
            }
        }
        Image {
            id: headLightImage
            source: "qrc:/image/iconidicator/headlight.png"
            width: 90
            height: 90
            x: 255
            y: 125
            visible: true
            opacity: 0.2
        }
    }
    Rectangle{
        width: parent.width*0.2
        height:220
        anchors.left: rectanGauge.right
        anchors.right: rectanPlot.left
        y: 770
        color: "black"
        radius: 10
        border.width: 5
        Column{
            id: column1
            x:0
            y:0
            width: parent.width/2
            height:parent.height
            spacing: 10
            Column{
                x:0
                y:0
                width: parent.width
                height:parent.height/2
                spacing: 10

                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Curent Latitude"
                    font.pixelSize: 20
                    color: "white"
                }
                Text{
                    id: textCurentLatitude
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "000.000000"
                    font.pixelSize: 33
                    color: "white"
                }
            }
            Column{
                x:0
                y:0
                width: parent.width
                height:parent.height/2
                spacing: 10
                Text{

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Next Latitude"
                    font.pixelSize: 20
                    color: "white"
                }
                Text{
                    id:  textNextLatitude
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "000.000000"
                    font.pixelSize: 33
                    color: "white"
                }
            }
        }
        Column{
            x:parent.width/2
            y:0
            width: parent.width/2
            height:parent.height
            spacing: 10
            Column{
                x:0
                y:0
                width: parent.width
                height:parent.height/2
                spacing: 10
                Text{

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Curent Longtitude"
                    font.pixelSize: 20
                    color: "white"
                }
                Text{
                    id: textCurentLongtitude
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "000.000000"
                    font.pixelSize: 33
                    color: "white"
                }
            }
            Column{
                x:0
                y:0
                width: parent.width
                height:parent.height/2
                spacing: 10
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Next Longtitude"
                    font.pixelSize: 20
                    color: "white"
                }
                Text{
                    id: textNextLongtitude
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "000.000000"
                    font.pixelSize: 33
                    color: "white"
                }
            }
        }


    }



    Rectangle{
        id: rectanPlot
        width: parent.width*0.4
        height:parent.height
        anchors.right:parent.right
        radius: 10
        border.width: 5
        border.color: "black"
        Rectangle{
            id: rectanglechartviewAcc
            width: parent.width
            height: parent.height/3
            anchors.left: parent.left
            radius: 10
            border.width: 5
            visible: false

            ChartView {
                id: chartViewAcc
                animationOptions: ChartView.SeriesAnimations
                //animationEasingCurve : easing
                animationDuration: 20
                antialiasing: true
                backgroundColor: "#EEE9E8"
                //visible: false
                anchors { fill: parent; margins: -5 }
                margins { right: 0; bottom: 0; left: 0; top: 0 }


                ValueAxis {
                    id: axisYacc
                    min: 0
                    max: 30
                    gridVisible: true
                    color: "black"
                    labelsColor: "black"
                    labelFormat: "%.0f"
                    titleText: "Deg"
                    tickCount: 9

                }

                ValueAxis {
                    id: axisXacc
                    min: 0
                    max: 200
                    gridVisible: true
                    color: "black"
                    labelsColor: "black"
                    labelFormat: "%.0f"
                    tickCount: 15
                    titleText: "TimeStep(1s)"
                }

                SplineSeries {
                    id: lineSeriesAccX
                    width: 2
                    //useOpenGL: true
                    name: "AccX"
                    color: "Blue"
                    axisX: axisXacc
                    axisY: axisYacc
                    //pointLabelsVisible: true

                }
                SplineSeries {
                    id: lineSeriesAccY
                    name: "AccY"
                    color: "Red"
                    axisX: axisXacc
                    axisY: axisYacc
                    width: 2
                    //pointLabelsVisible: true
                }

            }

        }
        Rectangle{
            id: rectanglechartviewPlotRoll
            width: parent.width
            height: parent.height/3
            anchors.left: parent.left
            radius: 10
            border.width: 5
            visible: true

            ChartView {
                id: chartViewRollPitch
                animationOptions: ChartView.SeriesAnimations
                //animationEasingCurve : easing
                animationDuration: 20
                antialiasing: true
                backgroundColor: "#EEE9E8"
                //visible: false
                anchors { fill: parent; margins: -5 }
                margins { right: 0; bottom: 0; left: 0; top: 0 }


                ValueAxis {
                    id: axisY
                    min: -20
                    max: 20
                    gridVisible: true
                    color: "black"
                    labelsColor: "black"
                    labelFormat: "%.0f"
                    titleText: "Deg"
                    tickCount: 9

                }

                ValueAxis {
                    id: axisX
                    min: 0
                    max: 200
                    gridVisible: true
                    color: "black"
                    labelsColor: "black"
                    labelFormat: "%.0f"
                    tickCount: 15

                    titleText: "TimeStep(1s)"
                }

                SplineSeries {
                    id: lineSeries1
                    width: 2
                    //useOpenGL: true
                    name: "Roll"
                    color: "Black"
                    axisX: axisX
                    axisY: axisY
                    //pointLabelsVisible: true

                }
                SplineSeries {
                    id: lineSeries2
                    name: "Pitch"
                    color: "Green"
                    axisX: axisX
                    axisY: axisY
                    width: 2
                    //pointLabelsVisible: true
                }

            }


        }
        Rectangle{
            width: parent.width
            height: parent.height*2/3
            anchors.right: parent.right
            anchors.top: rectanglechartviewPlotRoll.bottom
            radius: 10
            border.width: 5


            ChartView {
                id: chartViewDistance
                animationOptions: ChartView.SeriesAnimations
                //animationEasingCurve : easing
                animationDuration: 20
                antialiasing: true
                backgroundColor: "#EEE9E8"
                anchors { fill: parent; margins: -5 }
                margins { right: 0; bottom: 0; left: 0; top: 0 }



                ValueAxis {
                    id: axisY1
                    min: -300
                    max: 0
                    gridVisible: true
                    color: "black"
                    labelsColor: "black"
                    labelFormat: "%.0f"
                    titleText: "Cm"
                    tickCount: 20

                }

                ValueAxis {
                    id: axisX1
                    min: 0
                    max: 200
                    gridVisible: true
                    color: "black"
                    labelsColor: "black"
                    labelFormat: "%.0f"
                    tickCount: 15
                    titleText: "TimeStep(1s)"
                }

                SplineSeries {
                    id: lineSeries3
                    width: 3
                    //useOpenGL: true
                    name: "Depth"
                    color: "Black"
                    axisX: axisX1
                    axisY: axisY1
                    //pointLabelsVisible: true

                }
            }

        }
        RoundButton{
            id: buttonConvert
            width: 90
            height: 40
            radius: 10
            x:10
            y:10
            icon{
                source: "qrc:/image/iconidicator/Iconconvert.png"
                height:50
            }
            text: "Angle"
            background: Rectangle {
                radius: 10
                color: parent.down ? "red" : "white"

            }
            onPressed: {
                if(rectanglechartviewAcc.visible==true){
                    rectanglechartviewAcc.visible=false
                    rectanglechartviewPlotRoll.visible=true
                    buttonConvert.text = "Angle"
                }
                else{
                    rectanglechartviewAcc.visible=true
                    rectanglechartviewPlotRoll.visible=false
                    buttonConvert.text = "Accel"
                }
            }
        }

    }
}




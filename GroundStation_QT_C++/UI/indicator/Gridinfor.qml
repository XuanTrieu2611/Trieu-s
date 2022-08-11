import QtQuick 2.0

Item {
    required property double gridheight
    required property double gridwidth
    property double pitch
    property double roll
    property double yaw
    property double voltage
    property double current
    property double battery
    Grid{
        id: root
        width: gridwidth
        height: gridheight
        columns: 3
        spacing: 0
        Rectangle {
            width: root.width/3
            height: 50
            color: "#555753"
            Text {
                text: qsTr("Roll")
                anchors.centerIn: parent
                font.pointSize: 20
                color: "red"
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                id: name1
                text: roll
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Deg")
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Picth")
                font.pointSize: 20
                anchors.centerIn: parent
                color: "red"
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                id: name3
                text: pitch
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Deg")
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Yaw")
                font.pointSize: 20
                anchors.centerIn: parent
                color: "red"
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                id: name5
                text: yaw
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Deg")
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Voltage")
                font.pointSize: 20
                anchors.centerIn: parent
                color: "red"
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                id: name7
                text: voltage
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("V")
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Current")
                font.pointSize: 20
                anchors.centerIn: parent
                color: "red"
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                id: name9
                text: current
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("A")
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("Battery")
                font.pointSize: 20
                anchors.centerIn: parent
                color: "red"
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                id: name11
                text: battery
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: root.width/3
            height: 50
            Text {
                text: qsTr("mAh")
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }

    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

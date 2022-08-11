import QtQuick 2.15

Item {
    height: 2 * radius

    required property double radius
    property double roll: 0
    property double pitch: 0
    readonly property double pixelPerDegree: 1.7

    property double deltaFaceX: 0
    property double deltaFaceY: 0
    width: 2 * radius


    CustomImage {
        anchors.fill: parent
        source: "qrc:/image/gauge/ai_back.svg"


    }

    CustomImage {
        id: face
        anchors.fill: parent
        source: "qrc:/image/gauge/ai_face.svg"
        transform:[
            Rotation{
            origin.x: 0.5 * face.width
            origin.y: 0.5 * face.height
            axis{
                x: 0
                y: 0
                z: 1
            }
            angle: -roll
            },

            Translate{
                x: deltaFaceX
                y: deltaFaceY
            }
            ]

    }

    CustomImage {
        anchors.fill: parent
        source: "qrc:/image/gauge/ai_ring.svg"

        rotation: -roll
    }

    CustomImage {
        anchors.fill: parent
        source: "qrc:/image/gauge/ai_case.svg"

    }
}



/*##^##
Designer {
    D{i:0;height:338;width:556}
}
##^##*/

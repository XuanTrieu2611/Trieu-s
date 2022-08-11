import QtQuick 2.9
import QtQuick.Window 2.0
import QtDataVisualization 1.2
import mytest 1.0

Window {
    id: window
    width: 600
    height: 400
    visible: true

    FlightModel {
        id: dataModel
    }

    Scatter3D {
        anchors.fill: parent
        Scatter3DSeries {
            itemSize: 0.1
            ItemModelScatterDataProxy {
                itemModel: dataModel

                xPosRole: "x"
                yPosRole: "y"
                zPosRole: "z"
            }
        }
    }
}

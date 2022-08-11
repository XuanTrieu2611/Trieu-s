
import QtQuick 2.5;
import QtLocation 5.6

MapQuickItem {
    id: marker
    anchorPoint.x: image1.width/4
    anchorPoint.y: image1.height
    coordinate: position
    sourceItem:Item{
        Image{
            id: image1
            source: "qrc:/image/mapimage/marker.png"
        }
        Text{
            id: numbers
            y: image1.height/10
            width: image1.width
            color: "white"
            font.bold: true
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            Component.onCompleted: {
                numbers.text = mymodel.getNumber(position)
            }
        }
    }
}


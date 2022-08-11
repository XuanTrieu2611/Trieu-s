import QtQuick 2.15
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "map"
import QtQml.Models 2.15
import XT.MarkerModel 1.0
ApplicationWindow {
    id : root
    width: 2000
    height: 1000
    visible: true
    color: "white"
    title: qsTr("USV GROUND STATION")
    MarkerModel{
        id: mymodel
    }
    Plugin {
        id: mapboxglPlugin
        name: "mapboxgl"
        //        PluginParameter {
        //            name: "mapboxgl.access_token";
        //            value: "pk.eyJ1IjoiZGFuaWVsdHJpZXUiLCJhIjoiY2w0YjFkdjBqMDEyNDNwcXY1cmcweHdkNSJ9.2DzEhkP3VV4J9nj-eBnfCQ"; //tonken mapbox
        //        }
        //        PluginParameter{
        //            name: "mapboxgl.mapping.additional_style_urls";
        //            value: "mapbox://styles/danieltrieu/cl4b0zif1006215p6vd84a4o3"; // style mapbox
        //        }
        PluginParameter{
            id: mapPluginParameter
            name: "mapboxgl.mapping.additional_style_urls";
            value: "mapbox://styles/danieltrieu/cl4b1ags6001314p8uelwh034"; // style mapbox
        }
    }
    Rectangle{
        id: rectanmap
        height: root.height
        width: root.width * 0.7
        radius: 5
        border.width: 5
        border.color: "black"
        Map {
            id:mapview
            width: parent.width-10
            height: parent.height -10
            anchors.horizontalCenter: rectanmap.horizontalCenter
            anchors.verticalCenter: rectanmap.verticalCenter
            plugin: mapboxglPlugin
            center: QtPositioning.coordinate(21.00626936983474, 105.84306169238081)
            zoomLevel: 16
            //fieldOfView: 20
            tilt: slider1.value
            bearing: slider2.value

            MapItemView{
                id: mapmarker
                model: mymodel
                delegate:Marker{
                }
            }
        }


        Text{
            id:lineEdit
            width: 100
            height: 100
        }

        MouseArea {
            id: mouseareamaker
            anchors.fill: parent
            property int lastX : -1
            property int lastY : -1
            property int cout: 0

            onPressed: {
                lastX = mouse.x
                lastY = mouse.y
            }

            onPositionChanged: {
                mapview.pan(lastX-mouse.x, lastY-mouse.y)
                lastX = mouse.x
                lastY = mouse.y
            }


            onDoubleClicked:  {
                var coordinate = mapview.toCoordinate(Qt.point(mouse.x,mouse.y))
                mymodel.addMarker(coordinate)
                lineEdit.text = ""+ mapview.toCoordinate(Qt.point(mouse.x,mouse.y)).latitude+"  "+mapview.toCoordinate(Qt.point(mouse.x,mouse.y)).longitude
                //mymodel.getNumber(coordinate)
                //column3Text.text = mymodel.getNumber(coordinate)


            }

        }
    }
    Rectangle{
        id: rectanList
        width: root.width*0.3
        height: root.height
        anchors.left: rectanmap.right
        color: "white"
        radius: 5
        border.width: 5
        border.color: "black"
        ListView{
            id: markerlist
            width: parent.width
            height: parent.width
            x: 10
            model: mymodel
            spacing: 5
            header:
                Text{
                text: "Marker"
                font.bold: true
                font.pixelSize: 40
            }

            delegate: Row{
                id:listRow
                //width: markerlist.width-
                height: 50
                //anchors.leftMargin: 100
                Rectangle {
                    color: "white"; width: 50; height: 50
                    Text{
                        id:column3Text
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: mymodel.getNumber(position)
                        font.pixelSize: 35

                    }
                }
                Rectangle {
                    color: "white"; width: 410; height: 50


                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: {
                            position.toString()
                        }
                        font.pixelSize: 24
                    }
                }
                Rectangle {
                    color: "white"; width: 90; height: 50
                    RoundButton{
                        anchors.fill: parent
                        radius:10

                        text: "Delete"
                        onClicked: {
                            mymodel.removeMarker(index)
                            console.log(index);
                            //mymodel.getLength()
                            for(var i = 0;i < mymodel.getLength();i++) {
                                var string1= mymodel.getNumber(mymodel.valueInPosition(i))
                                console.log(string1)

                                lineEdit.text = string1

                            }
                            mymodel.getList()
                        }

                    }
                }
            }

        }
    }
    Slider{
        id: slider1
        width: mapview.width-100
        height:50
        x:0
        y:-5
        from: 0
        to :60
    }
    Text{
        text: "Tilt"
        width: 100
        height:50
        y:10
        anchors.left: slider1.right
        anchors.leftMargin: 20
        font.pixelSize: 20

    }

    Slider{
        id: slider2
        width: mapview.width-100
        height:50
        anchors.top: slider1.bottom
        from: 0
        to :360
    }
    Text{
        text: "Bearing"
        width: 100
        height:50
        y:50
        anchors.left: slider2.right
        anchors.leftMargin: 20
        font.pixelSize: 20

    }

}


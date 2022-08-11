import QtQuick 2.15
import QtQuick.Window 2.15
import QtLocation 5.6
import QtPositioning 5.6

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Plugin {
          id: mapboxglPlugin
          name: "mapboxgl"
          PluginParameter {
              name: "mapboxgl.access_token";
              value: "pk.eyJ1IjoiZGFuaWVsdHJpZXUiLCJhIjoiY2w0YjFkdjBqMDEyNDNwcXY1cmcweHdkNSJ9.2DzEhkP3VV4J9nj-eBnfCQ"; //tonken mapbox
          }
          PluginParameter{
              name: "mapboxgl.mapping.additional_style_urls";
              value: "mapbox://styles/danieltrieu/cl4b0zif1006215p6vd84a4o3"; // style mapbox
          }
       }

       Map {
          anchors.fill: parent
          plugin: mapboxglPlugin
          center: QtPositioning.coordinate(21.00626936983474, 105.84306169238081)
          zoomLevel: 16
          }
}

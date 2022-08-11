import QtQuick 2.0
import QtQuick.Controls 2.15


MenuBar {
    property variant  providerMenu: providerMenu
    property variant  mapTypeMenu: mapTypeMenu
    property variant  toolsMenu: toolsMenu
    signal selectProvider(string providerName)
    signal selectMapType(variant mapType)
    signal selectTool(string tool);
    signal toggleMapState(string state)
    Menu {
        id: providerMenu
        title: qsTr("Provider")
        MenuItem{
            text: "aaa"
        }
        MenuItem{
            text: "bbb"
        }
    }
    Menu {
        id: mapTypeMenu
        title: qsTr("MapType")
    }
    Menu {
        id: toolsMenu
        title: qsTr("Tools")
    }

}

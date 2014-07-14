import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.1
import "./js/Style.js" as Style
import "./components"
import "./views"

/*
  main qml file that makes the window and menu
 */
ApplicationWindow {
    visible: true
    width: Style.defaultWidth
    height: Style.defaultHeight
    minimumWidth: Style.minimumWidth
    minimumHeight: Style.minimumHeight
    title: qsTr("MineSense Demo")

    /*
      Menu bar with:
            File
                Save
                Load
                Quit
     */
    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Load")
                onTriggered:
                    loadDialog.open()
            }
            MenuItem {
                text: qsTr("Save")
                onTriggered:
                    saveDialog.open()
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit()
            }
        }
    }

    /*
      Dialog window for saving
     */
    FileDialog {
        id: saveDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
            controller.saveData(saveDialog.fileUrl.toString().substring(8))
        }
    }

    /*
      Dialog window for loading
     */
    FileDialog {
        id: loadDialog
        title: "Please choose a file"
        selectMultiple: false
        nameFilters: [ "Comma-Seprated Files (*.csv)", "All files (*)" ]
        onAccepted: {
            controller.loadData(loadDialog.fileUrl.toString().substring(8))
            mainView.setLoaded()
        }
    }

    /*
      The main view
     */
    GraphView {
        id: mainView
    }

}

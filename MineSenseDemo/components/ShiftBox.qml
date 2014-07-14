import QtQuick 2.2
import QtQuick.Controls 1.1

/*
  A control box that can set an increase/decrease amount
 */
Item {
    id: root
    width: 100
    height: 100
    property color color: "grey"    //Background color
    property int innerMargins: 5    //Margins inside the ShiftBox
    property int buttonWidth: 40    //Width of the buttons
    property int buttonHeight: 20   //Height of the buttons

    signal shift(real value)        //Shift has be commited

    /*
      Main container rectangle
     */
    Rectangle {
        id: shiftBox
        color: root.color

        anchors.fill: root

        /*
          Title of the ShiftBox
         */
        Text {
            id: shiftBoxTitle
            text: qsTr("Shift")

            anchors.horizontalCenter: shiftBox.horizontalCenter
            anchors.top: shiftBox.top
            anchors.margins: root.innerMargins
        }

        /*
          Container of the buttons and textfield
         */
        Rectangle {
            id: shiftBoxInner
            width: shiftBox.width
            height: shiftBox.height - shiftBoxTitle.height - (root.innerMargins * 2)
            color: root.color

            anchors.top: shiftBoxTitle.bottom

            /*
              Button to increase value
             */
            Button {
                id: shiftBoxUpButton
                width: root.buttonWidth
                height: root.buttonHeight
                text: qsTr("Up")

                anchors.bottom: shiftBoxInner.verticalCenter
                anchors.left: shiftBoxInner.left
                anchors.leftMargin: root.innerMargins

                onClicked: {
                    var v = parseFloat(shiftBoxTextField.text)
                    if(!isNaN(v))
                        root.shift(v)
                }
            }

            /*
              Button to decrease value
             */
            Button {
                id: shiftBoxDownButton
                width: root.buttonWidth
                height: root.buttonHeight
                text: qsTr("Down")

                anchors.top: shiftBoxInner.verticalCenter
                anchors.left: shiftBoxInner.left
                anchors.leftMargin: root.innerMargins

                onClicked: {
                    var v = parseFloat(shiftBoxTextField.text)
                    if(!isNaN(v))
                        root.shift(-v)
                }
            }

            /*
              Amount to be increased/decreased
             */
            TextField {
                id: shiftBoxTextField
                width: shiftBox.width - root.buttonWidth - (root.innerMargins * 3)
                placeholderText: qsTr("Amount")

                anchors.right: shiftBoxInner.right
                anchors.verticalCenter: shiftBoxInner.verticalCenter
                anchors.margins: root.innerMargins
            }
        }
    }
}

import QtQuick 2.0
import QtQuick.Controls 1.1

/*
  Control box to adjust the view of a graph
 */
Item {
    id: root
    width: 400
    height: 50
    property color color: "grey"    //Background color
    property real xDelta: 2         //The amount to scroll in x
    property real yDelta: 50        //The amount to scroll in y
    property int buttonWidth: 50    //Width of the buttons
    property int innerMargins: 10   //Margins inside the ViewBox
    property real xSegmentSize: 5   //The unit spacing in x axis
    property real ySegmentSize: 50  //The unit spacing in y axis
    property real minX: 0           //The start x value
    property real maxX: 20          //The end x value
    property real minY: 0           //The start y value
    property real maxY: 500         //The end y value

    /*
      The main container rectangle
     */
    Rectangle {
        id: innerBox
        color: root.color
        anchors.fill: parent

        /*
          Button that controls right scrolling
         */
        Button {
            id: rightButton
            width: buttonWidth / 2
            height: buttonWidth
            text: qsTr(">")
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: innerMargins

            onClicked: {
                minX += xDelta
                maxX += xDelta
            }
        }

        /*
          Buttons that controls left scrolling
         */
        Button {
            id: leftButton
            width: buttonWidth / 2
            height: buttonWidth
            text: qsTr("<")
            anchors.right: upButton.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: innerMargins
            onClicked: {
                minX -= xDelta
                maxX -= xDelta
            }
        }

        /*
          Button that controls up scrolling
         */
        Button {
            id: upButton
            width: buttonWidth
            height: buttonWidth / 2
            text: qsTr("^")
            anchors.right: rightButton.left
            anchors.bottom: parent.verticalCenter
            anchors.margins: innerMargins

            onClicked: {
                minY += yDelta
                maxY += yDelta
            }
        }

        /*
          Button that controls down scrolling
         */
        Button {
            id: downButton
            width: buttonWidth
            height: buttonWidth / 2
            text: qsTr("v")
            anchors.right: rightButton.left
            anchors.top: parent.verticalCenter
            anchors.margins: innerMargins

            onClicked: {
                minY -= yDelta
                maxY -= yDelta
            }
        }

        /*
          Button that controls zooming in in x axis
         */
        Button {
            id: zoomInXButton
            width: buttonWidth * 2
            height: buttonWidth / 2
            text: qsTr("Zoom In X")
            anchors.right: leftButton.left
            anchors.bottom: parent.verticalCenter
            anchors.margins: innerMargins
            anchors.rightMargin: innerMargins * 4

            onClicked: {
                minX += xDelta
                maxX -= xDelta
            }
        }

        /*
          Button that controls zooming out in x axis
         */
        Button {
            id: zoomOutXButton
            width: buttonWidth * 2
            height: buttonWidth / 2
            text: qsTr("Zoom Out X")
            anchors.right: leftButton.left
            anchors.top: parent.verticalCenter
            anchors.margins: innerMargins
            anchors.rightMargin: innerMargins * 4

            onClicked: {
                minX -= xDelta
                maxX += xDelta
            }
        }

        /*
          Button that controls zooming in in y axis
         */
        Button {
            id: zoomInYButton
            width: buttonWidth * 2
            height: buttonWidth / 2
            text: qsTr("Zoom In Y")
            anchors.right: zoomInXButton.left
            anchors.bottom: parent.verticalCenter
            anchors.margins: innerMargins

            onClicked: {
                minY += yDelta
                maxY -= yDelta
            }
        }

        /*
          Button that controls zooming out in y axis
         */
        Button {
            id: zoomOutYButton
            width: buttonWidth * 2
            height: buttonWidth / 2
            text: qsTr("Zoom Out Y")
            anchors.right: zoomInXButton.left
            anchors.top: parent.verticalCenter
            anchors.margins: innerMargins

            onClicked: {
                minY -= yDelta
                maxY += yDelta
            }
        }

        /*
          Label for x interval amout
         */
        Text {
            id: xSegLabel
            width: buttonWidth * 2
            text: qsTr("X Unit Interval: ")
            anchors.left: parent.left
            anchors.verticalCenter: xSegTextField.verticalCenter
        }

        /*
          Label for y interval amount
         */
        Text {
            id: ySegLabel
            width: buttonWidth * 2
            text: qsTr("Y Unit Interval: ")
            anchors.left: parent.left
            anchors.verticalCenter: ySegTextField.verticalCenter
        }

        /*
          Textfield to input x interval
         */
        TextField {
            id: xSegTextField
            width: buttonWidth
            height: buttonWidth / 2
            placeholderText: xSegmentSize
            anchors.left: xSegLabel.right
            anchors.bottom: parent.verticalCenter
            anchors.margins: innerMargins
        }

        /*
          Textfield to input y interval
         */
        TextField {
            id: ySegTextField
            width: buttonWidth
            height: buttonWidth / 2
            placeholderText: ySegmentSize
            anchors.left: ySegLabel.right
            anchors.top: parent.verticalCenter
            anchors.margins: innerMargins
        }

        /*
          Button to commit interval changes
         */
        Button {
            id: segButton
            width: buttonWidth
            height: ySegTextField.height
            text: qsTr("Update")
            anchors.left: ySegTextField.right
            anchors.verticalCenter: ySegTextField.verticalCenter
            anchors.margins: innerMargins

            onClicked: {
                var x = parseFloat(xSegTextField.text)
                var y = parseFloat(ySegTextField.text)
                if(!isNaN(x))
                    xSegmentSize = x
                if(!isNaN(y))
                    ySegmentSize = y
            }
        }
    }
}

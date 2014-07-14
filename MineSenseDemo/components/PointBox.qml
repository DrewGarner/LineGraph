import QtQuick 2.2
import QtQuick.Controls 1.1

/*
  A control box that can view and set an x and y value
 */
Item {
    id: root
    width: 300
    height: 100
    property color color: "grey"                //Background color
    property int innerMargins: 5                //Sive of margins inside
    property int labelWidth: 100                //Width of the labels
    property string xAxisLabel: qsTr("X Axis:") //X value labal
    property string yAxisLabel: qsTr("Y Axis:") //Y value label
    property int index: 0                       //Index of current point

    signal updated(int index, real x, real y)   //Values have been changed

    /*
      Set the data of PointBox
      Parameters: i - index of current point
                  x - x value
                  y - y value
     */
    function setData(i, x, y) {
        index = i
        pointBoxXAxisValue.text = x
        pointBoxYAxisValue.text = y
    }

    /*
      Set the x value label
      Parameters: label - new x label
     */
    function setXLabel(label) {
        pointBoxXAxisLabel.text = label
    }

    /*
      Set the y value label
      Parameters: label - new y label
     */
    function setYLabel(label) {
        pointBoxYAxisLabel.text = label
    }

    /*
      Set the x value
      Parameters: value - new x value
     */
    function setX(value){
        pointBoxXAxisValue.text = value
    }

    /*
      Set the y value
      Parameters: value - new y value
     */
    function setY(value){
        pointBoxYAxisValue.text = value
    }

    /*
      Set the index value
      Parameters: value - new index value
     */
    function setIndex(value){
        index = value
    }

    /*
      Get the x value
      returns: real - x value
     */
    function getX() {
        return parseFloat(pointBoxXAxisValue.text)
    }

    /*
      Get the y value
      returns: real - y value
     */
    function getY() {
        return parseFloat(pointBoxYAxisValue.text)
    }

    /*
      Get the index value
      returns: integer - index value
     */
    function getIndex() {
        return index
    }

    /*
      Main containing Rectangle
     */
    Rectangle {
        id: pointBox
        color: root.color

        anchors.fill: parent

        /*
          PointBox title
         */
        Text {
            id: pointBoxTitle
            text: qsTr("Point")

            anchors.horizontalCenter: pointBox.horizontalCenter
            anchors.top: pointBox.top
            anchors.margins: root.innerMargins
        }

        /*
          Container of textfields and buttons
         */
        Rectangle {
            id: pointBoxInner
            width: pointBox.width
            height: pointBox.height - pointBoxTitle.height - root.innerMargins
            color: root.color

            anchors.top: pointBoxTitle.bottom

            /*
              Label of x value
             */
            Text {
                id: pointBoxXAxisLabel
                width: root.labelWidth
                horizontalAlignment: Text.AlignRight
                text: root.xAxisLabel

                anchors.bottom: pointBoxInner.verticalCenter
                anchors.left: pointBoxInner.left
                anchors.leftMargin: root.innerMargins
                anchors.bottomMargin: root.innerMargins
            }

            /*
              Label of y value
             */
            Text {
                id: pointBoxYAxisLabel
                width: root.labelWidth
                horizontalAlignment: Text.AlignRight
                text: root.yAxisLabel

                anchors.top: pointBoxInner.verticalCenter
                anchors.left: pointBoxInner.left
                anchors.leftMargin: root.innerMargins
                anchors.topMargin: root.innerMargins
            }

            /*
              X value
             */
            TextField {
                id: pointBoxXAxisValue
                width: root.pointBoxValueWidth

                anchors.left: pointBoxXAxisLabel.right
                anchors.verticalCenter: pointBoxXAxisLabel.verticalCenter
                anchors.leftMargin: root.pointBoxMargins
            }

            /*
              Y value
             */
            TextField {
                id: pointBoxYAxisValue
                width: root.pointBoxValueWidth

                anchors.left: pointBoxYAxisLabel.right
                anchors.verticalCenter: pointBoxYAxisLabel.verticalCenter
                anchors.leftMargin: root.pointBoxMargins
            }

            /*
              Button to commit changes
             */
            Button {
                id: pointBoxUpdateButton
                width: root.pointBoxUpdateButtonWidth
                text: qsTr("Update")

                anchors.right: pointBoxInner.right
                anchors.bottom: pointBoxInner.bottom
                anchors.margins: root.innerMargins

                onClicked: {
                    root.updated(getIndex(), getX(), getY())
                }
            }
        }
    }

}

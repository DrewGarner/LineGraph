import QtQuick 2.2
import QtQuick.Controls 1.1
import "../js/Style.js" as Style
import "../components"

/*
  A main view that displays a graph control boxs to manipulate the display and values
  of the grpah.
  Uses 'dataModel' - an array of x and y values
       'dataTitle' - an array of titles for x axis and y axis
 */
Item {
    anchors.fill: parent
    property bool dataLoaded: false //Whether data has be loaded

    /*
      Set true that data has been loaded
     */
    function setLoaded() {
        dataLoaded = true
        graph.setPoints(dataModel)
        graph.setTitles(dataTitle[0], dataTitle[1])
        pointBox.setXLabel(dataTitle[0])
        pointBox.setYLabel(dataTitle[1])
    }

    /*
      Main container rectangle
     */
    Rectangle {
        id: root
        width: parent.width
        height: parent.height
        color: "red"

        anchors.centerIn: parent

        /*
          A line graph that displays the dataModel
         */
        LineGraph {
            id: graph
            width: parent.width
            height: parent.height - Style.ctrlBoxHeight - Style.viewBoxHeight
            axisBuffer: Style.graphAxisBuffer
            xSegmentSize: Style.graphDefaultXSegmentSize
            ySegmentSize: Style.graphDefaultYSegmentSize
            subSeg: Style.graphSubSeg
            minX: Style.graphDefaultMinX
            maxX: Style.graphDefaultMaxX
            minY: Style.graphDefaultMinY
            maxY: Style.graphDefaultMaxY

            anchors.top: parent.top
        }

        /*
          MouseArea over the LineGraph to interact with it
         */
        MouseArea {
            id: graphMouse
            width: parent.width
            height: parent.height - Style.ctrlBoxHeight
            hoverEnabled: true
            anchors.top: parent.top

            onMouseXChanged: {
                if(dataLoaded){
                    graph.hoverPoint(mouseX, mouseY)
                }
            }
            onClicked: {
                if(dataLoaded){
                    var i = graph.clickPoint(mouseX, mouseY)
                    if(i >= 0) {
                        pointBox.setData(i, dataModel[i].x, dataModel[i].y)
                        graph.setPoints(dataModel)
                    }
                }
            }
        }

        /*
          Control box to alter display of the Graph
         */
        ViewBox {
            id: viewBox
            width: parent.width
            height: Style.viewBoxHeight
            color: Style.viewBoxColor
            innerMargins: Style.viewBoxMargins
            buttonWidth: Style.viewBoxButtonWidth
            xSegmentSize: Style.graphDefaultXSegmentSize
            ySegmentSize: Style.graphDefaultYSegmentSize
            minX: Style.graphDefaultMinX
            maxX: Style.graphDefaultMaxX
            minY: Style.graphDefaultMinY
            maxY: Style.graphDefaultMaxY
            anchors.top: graph.bottom

            onMinXChanged: {
                if(dataLoaded){
                    graph.minX = minX
                    graph.setPoints(dataModel)
                }
            }
            onMaxXChanged: {
                if(dataLoaded){
                    graph.maxX = maxX
                    graph.setPoints(dataModel)
                }
            }
            onMinYChanged: {
                if(dataLoaded){
                    graph.minY = minY
                    graph.setPoints(dataModel)
                }
            }
            onMaxYChanged: {
                if(dataLoaded){
                    graph.maxY = maxY
                    graph.setPoints(dataModel)
                }
            }
            onXSegmentSizeChanged: {
                if(dataLoaded){
                    graph.xSegmentSize = xSegmentSize
                    graph.setPoints(dataModel)
                }
            }
            onYSegmentSizeChanged: {
                graph.ySegmentSize = ySegmentSize
                graph.setPoints(dataModel)
            }
        }

        /*
          Rectangle containing data altering controls
         */
        Rectangle {
            id: ctrlBox
            width: root.width
            height: Style.ctrlBoxHeight
            color: Style.ctrlBoxBorderColor

            anchors.bottom: root.bottom

            /*
              Control box that allows shifting of point y values
             */
            ShiftBox {
                id: shiftBox
                color: Style.ctrlBoxInnerColor
                width: Style.shiftBoxWidth
                height: Style.ctrlBoxHeight - (Style.shiftBoxMargins * 2)
                innerMargins: Style.shiftBoxMargins
                buttonWidth: Style.shiftBoxButtonWidth
                buttonHeight: Style.shiftBoxButtonHeight
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: Style.ctrlBoxMargins

                onShift: {
                    if(dataLoaded) {
                        var i = graph.getHighLightIndex()
                        if(i >= 0) {
                            controller.shiftData(i, value)
                            graph.setPoints(dataModel)
                        }
                    }
                }
            }

            /*
              Control box that allows direct altering of a specific point
             */
            PointBox {
                id: pointBox
                color: Style.ctrlBoxInnerColor
                width: Style.pointBoxWidth
                height: Style.ctrlBoxHeight - (Style.pointBoxMargins * 2)
                innerMargins: Style.pointBoxMargins
                labelWidth: Style.pointBoxLabelWidth
                xAxisLabel: Style.pointBoxXAxisLabel
                yAxisLabel: Style.pointBoxYAxisLabel
                anchors.right: shiftBox.left
                anchors.top: parent.top
                anchors.margins: Style.ctrlBoxMargins

                onUpdated: {
                    if(dataLoaded) {
                        controller.setData(index, x, y)
                        graph.setPoints(dataModel)
                    }
                }
            }
        }
    }

    /*
      Redraw graph on width change
     */
    onWidthChanged: {
        if(dataLoaded)
            graph.setPoints(dataModel)
    }

    /*
      Redraw graph on height change
     */
    onHeightChanged: {
        if(dataLoaded)
            graph.setPoints(dataModel)
    }

}

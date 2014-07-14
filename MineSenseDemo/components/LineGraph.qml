import QtQuick 2.2
import QtQuick.Controls 1.1

/*
  This is a line graph that interpolates data so only portions can be
  viewed based of min and max x and y values.
 */
Item {
    id: root
    width: 400
    height: 200

    property color bgColor: "white"         //Color of background
    property color lineColor: "blue"        //Color of line
    property color highlightColor: "orange" //Color of highlighted point
    property color axisColor: "grey"        //Color of axis scale
    property string xAxisTitle: "X"         //Title of x axis
    property string yAxisTile: "Y"          //Title of y axis
    property int axisBuffer: 40             //Space between axis and edge of canvas
    property real xSegmentSize: 5           //Unit spacing in x axis
    property real ySegmentSize: 50          //Unit spacing in y axis
    property int segLineLength: 20          //Length of tick line
    property int subSeg: 5                  //Number of sub ticks between segments
    property int pointDiameter: 5           //Diameter of point
    property real minX: 0                   //Start x value
    property real maxX: 20                  //End x value
    property real minY: 0                   //Start y value
    property real maxY: 500                 //End y value
    property int mX: 0       //Used internally - x position of mouse
    property int hIndex: -1  //Used internally - index of highlighted point
    property int minIndex: 0 //Used internally - index of viewable subset of points

    /*
      Draw lines onto canvas
     */
    function drawLines() {
        if(points.count > 0)
        {
            var ctx = canvas.getContext('2d')
            ctx.lineWidth = 2
            ctx.strokeStyle = Qt.lighter(root.lineColor)

            ctx.beginPath()
            ctx.moveTo(points.get(0).x, points.get(0).y)
            for (var index = 1; index < points.count; index++) {
                ctx.lineTo(points.get(index).x, points.get(index).y)
            }
            ctx.stroke()
        }
    }

    /*
      Draw axis and labesl onto canvas
     */
    function drawAxis() {
        var ctx = canvas.getContext('2d')
        ctx.lineWidth = 2
        ctx.strokeStyle = Qt.lighter(root.axisColor)

        ctx.beginPath()
        ctx.moveTo(axisBuffer, axisBuffer)
        ctx.lineTo(axisBuffer, canvas.height - axisBuffer)
        ctx.lineTo(canvas.width - axisBuffer, canvas.height - axisBuffer)

        var xSegCount = (maxX - minX) / xSegmentSize
        var xSegPix = xSegmentSize/(maxX - minX) * (canvas.width - 2 * axisBuffer)
        for(var i = 0; i < xSegCount; i++)
        {
            var x = axisBuffer + (i * xSegPix)
            ctx.moveTo(x, canvas.height - (axisBuffer * 3 / 4))
            ctx.lineTo(x, canvas.height - axisBuffer - segLineLength)
            for(var j = 1; j < subSeg; j++)
            {
                ctx.moveTo(x + (j * xSegPix / subSeg), canvas.height - axisBuffer)
                ctx.lineTo(x + (j * xSegPix / subSeg), canvas.height - axisBuffer - (segLineLength / 2))
            }
            ctx.text(i * xSegmentSize + minX, x, canvas.height - (axisBuffer / 2))
        }
        var ySegCount = (maxY - minY) / ySegmentSize
        var ySegPix = ySegmentSize/(maxY - minY) * (canvas.height - 2 * axisBuffer)
        for(i = 0; i < ySegCount; i++)
        {
            var y = canvas.height - (axisBuffer + (i * ySegPix))
            ctx.moveTo(axisBuffer * 3 / 4, y)
            ctx.lineTo(axisBuffer + segLineLength, y)
            for(j = 1; j < subSeg; j++)
            {
                ctx.moveTo(axisBuffer, y - (j * ySegPix / subSeg))
                ctx.lineTo(axisBuffer + (segLineLength / 2), y - (j * ySegPix / subSeg))
            }
            ctx.text(i * ySegmentSize + minY, axisBuffer / 4, y)
        }
        ctx.text(xAxisTitle, axisBuffer * 2, canvas.height - (axisBuffer / 4))
        ctx.text(yAxisTile, axisBuffer / 2, axisBuffer / 2)
        ctx.stroke()
    }

    /*
      Draw hover point onto canvas
     */
    function drawPoint() {
        if(points.count <= 0) {
            return
        }
        var i = getPointIndex(mX)
        if(i < 0 || i >= points.count) {
            return
        }
        var ctx = canvas.getContext('2d')
        ctx.strokeStyle = Qt.lighter(root.lineColor)
        ctx.beginPath()
        ctx.ellipse(points.get(i).x - (pointDiameter / 2), points.get(i).y - (pointDiameter / 2), pointDiameter, pointDiameter)
        ctx.stroke();

    }

    /*
      Draw highlighted point onto canvas
     */
    function drawHighLight() {
        if(points.count <= 0) {
            return
        }
        if(hIndex < 0 || hIndex >= points.count) {
            return
        }

        var ctx = canvas.getContext('2d')
        ctx.strokeStyle = Qt.lighter(root.highlightColor)
        ctx.beginPath()
        ctx.ellipse(points.get(hIndex).x - (pointDiameter / 2), points.get(hIndex).y - (pointDiameter / 2), pointDiameter, pointDiameter)
        ctx.stroke()
    }

    /*
      Set interpolated viewable points from the given data
      Parameters - Data - an array with x and y value
     */
    function setPoints(data) {
        if(canvas.width == 0) {
            return
        }
        var xRange = maxX - minX
        var yRange = maxY - minY
        points.clear()
        var passMin = false
        for(var i = 0; i < data.length; i++)
        {
            var x = data[i].x
            var y = data[i].y
            if(x >= minX && x <= maxX)
            {
                if(!passMin) {
                    passMin = true
                    minIndex = i
                }
                points.append({
                                "x": (x - minX)/xRange * (canvas.width - axisBuffer * 2) + axisBuffer,
                                "y": canvas.height - ((y - minY)/yRange * canvas.height + axisBuffer)
                              })
            }
        }
        canvas.requestPaint()
    }

    /*
      Set the axis titles
      Paramters: x - the x axis title
                 y - the y axis title
     */
    function setTitles(x, y) {
        xAxisTitle = x
        yAxisTile = y
        canvas.requestPaint()
    }

    /*
      Get the absolute index from the viewable subset index
      Parameters: relativeIndex - index of viewable subset
      returns: integer index
     */
    function getAbsoluteIndex(relativeIndex) {
        return minIndex + relativeIndex
    }

    /*
      Get index of a point at x coordinate
      Parameters: x - x pixel coordinate
      returns: integer index
     */
    function getPointIndex(x) {
        if(points.count == 0) {
            return 0
        }
        var i = 1
        while(points.get(i).x < x && i < points.count - 1)
            i++
        if(points.get(i).x - x < x - points.get(i-1))
            return i
        return i - 1
    }

    /*
      Set secondary highlighted point
      Parameters: x - x pixel coordinate
                  y - y pixel coordinate
      returns: integer index of highlighted point
     */
    function hoverPoint(x, y) {
        if(mX != x) {
            mX = x
            canvas.requestPaint()
        }
        if(points.count == 0) {
            return 0
        }
        return getAbsoluteIndex(getPointIndex(x))
    }

    /*
      Set highlighted point
      Parameters: x - x pixel coordinate
                  y - y pixel coordinate
      returns: integer index of highlighted point
     */
    function clickPoint(x, y) {
        hIndex = getPointIndex(x)
        if(points.count == 0) {
            return 0
        }
        canvas.requestPaint()
        return getAbsoluteIndex(hIndex)
    }

    /*
      Get the absolute index of the highlighted point
     */
    function getHighLightIndex()
    {
        return getAbsoluteIndex(hIndex)
    }

    /*
      Request repaint of canvas
     */
    function requestPaint() {
        canvas.requestPaint()
    }

    /*
      Main canvas where all drawing takes place
     */
    Canvas {
        id: canvas
        antialiasing: false
        anchors.fill: parent
        onPaint: {
            var ctx = canvas.getContext('2d')
            ctx.fillStyle = root.bgColor
            ctx.fillRect(0, 0, width, height)

            drawAxis()
            drawLines()
            drawPoint()
            drawHighLight()
        }
    }

    /*
      Viewable subset of points
     */
    ListModel {
        id: points
    }

}

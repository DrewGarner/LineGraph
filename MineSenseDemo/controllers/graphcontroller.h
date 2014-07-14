#ifndef GRAPHCONTROLLER_H
#define GRAPHCONTROLLER_H

#include <QObject>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QStringListModel>
#include <QQmlContext>
#include <iostream>
#include <stdlib.h>
#include "../helpers/csvfilehandler.h"
#include "../models/csvmodel.h"

/**
 * GraphController is a controller class that controls qml objects.
 * It uses data structures 'dataModel'- an array of x,y values and
 *  'dataTitle' and array of axis titles.
 *
 * @author Drew Garner
 */
class GraphController : public QObject
{
    Q_OBJECT
public:
    /*
     * Purpose: Constructor for Controller
     * Parameters:  parent - the QObject that contains this object
     *              view   - the qml root context that needs to be conbtrolled
     *              model  - the data model
     * return: n/a
     */
    explicit GraphController(QObject *parent = 0, QQmlContext *view = 0, CsvModel *model = 0);
    /*
     * Purpose: Takes data from the model and pushes it to the view as 'dataModel'
     * Parameter:   address - the absolute address of the file to be read
     * return: n/a
     */
    Q_INVOKABLE void loadData(QString address);
    /*
     * Purpose: Save the current data into a file
     * Parameter:   address - the absolute address of the file to be written
     * return: n/a
     */
    Q_INVOKABLE void saveData(QString address);
    /*
     * Purpose: Set value of x and y in index i
     * Parameters:  i - index of data to be changed
     *              x - new x value
     *              y - new y value
     * return: n/a
     */
    Q_INVOKABLE void setData(size_t i, qreal x, qreal y);
    /*
     * Purpose: To add a value to the current Y value of index i
     * Parameters:  i - index of data to be changed
     *              v - value to be added to y
     * return: n/a
     */
    Q_INVOKABLE void shiftData(size_t i, qreal v);
private:
    QQmlContext    *view_;      //Pointer to the view
    QList<QObject*> dataList_;  //The model data formatted for qml usage
    CsvModel       *model_;     //Pointer to model
};

/**
 * A simple object that holds an X value and Y value formatted for usage
 * in qml
 *
 * @author Drew Garner
 */
class DataObject : public QObject
{
     Q_OBJECT

     Q_PROPERTY(qreal x READ x WRITE setX NOTIFY xChanged)
     Q_PROPERTY(qreal y READ y WRITE setY NOTIFY yChanged)
public:
    /*
     * Purpose: Constructor for DataObject
     * Paramters:   x - x value
     *              y - Y value
     * return: n/a
     */
    explicit DataObject(double x = 0, double y = 0) {
        setX(x);
        setY(y);
    }
    /*
     * Purpose: Get X value
     * Parameters: n/a
     * return: x value
     */
    qreal x() {
        return m_x;
    }
    /*
     * Purpose: Get Y value
     * Parameters: n/a
     * return: y value
     */
    qreal y() {
        return m_y;
    }
    /*
     * Purpose: set the x value
     * Parameters: v - new x value
     * return: n/a
     */
    void setX(double v) {
        m_x = v;
        emit xChanged(v);
    }
    /*
     * Purpose: set the y value
     * Parameters: v - new y value
     * return: n/a
     */
    void setY(double v) {
        m_y = v;
        emit yChanged(v);
    }
signals:
    void xChanged(qreal);
    void yChanged(qreal);
private:
    qreal m_x;
    qreal m_y;
};

#endif // GRAPHCONTROLLER_H

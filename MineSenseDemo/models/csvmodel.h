#ifndef CSVMODEL_H
#define CSVMODEL_H

#include <vector>

using namespace std;

/**
 * CsvModel is a model object that contains data from a csv file
 *
 * @author Drew Garner
 */
class CsvModel
{
public:
    /*
     * Purpose: Constructor for CsvModel
     * Parameters:  address - address of the csv file
     *              xTitle  - title of the x axis
     *              yTitle  - title of the y axis
     * return: n/a
     */
    CsvModel(string address = "", string xTitle = "", string yTitle = "");
    /*
     * Purpose: Get address
     * Parameters: n/a
     * return: address
     */
    string getAddress();
    /*
     * Purpose: Get x axis title
     * Parameters: n/a
     * return: title
     */
    string getXTitle();
    /*
     * Purpose: Get y axis title
     * Parameters: n/a
     * return: title
     */
    string getYTitle();
    /*
     * Purpose: Get the x and y value from index
     * Parameters:  index - index of requested data
     * return: a pair where first is x value and second is y value
     */
    pair<double, double> getData(size_t index);
    /*
     * Purpose: Get all x and y values
     * Parameters: n/a
     * return: a vector of pairs where first is x value and second is y value
     */
    vector<pair<double,double>> getAllData();    
    /*
     * Purpose: Set address
     * Parameters: a - new address
     * return: n/a
     */
    void setAdress(string a);
    /*
     * Purpose: Set x axis title
     * Parameters: t - new title
     * return: n/a
     */
    void setXTitle(string t);
    /*
     * Purpose: Set y axis title
     * Parameters: t - new title
     * return: n/a
     */
    void setYTitle(string t);
    /*
     * Purpose: Set x and y at index
     * Parameters:  index - index of data to be changed
     *              x     - new x value
     *              y     - new y value
     * return: n/a
     */
    void setData(size_t index, double x, double y);
    /*
     * Purpose: Set X value
     * Parameters: index - index of data to be changed
     *             x     - new x value
     * return: n/a
     */
    void setX(size_t index, double x);
    /*
     * Purpose: Set Y value
     * Parameters: index - index of data to be changed
     *             y     - new y value
     * return: n/a
     */
    void setY(size_t index, double y);
    /*
     * Purpose: Inserts data after index
     * Parameters: index - index of data to be inserted after
     *             x     - new x value
     *             y     - new y value
     * return: n/a
     */
    void insertData(size_t index, double x, double y);
    /*
     * Purpose: Add data at the end of the list
     * Parameters:  x - new x value
     *              y - new y value
     * return: n/a
     */
    void addData(double x, double y);
    /*
     * Purpose: Remove data at index
     * Parameters: index - index of data to removed
     * return: n/a
     */
    void removeData(size_t index);
    /*
     * Purpose: Clear all data
     * Parameters: n/a
     * return: n/a
     */
    void clearData();

private:
    string address_;
    string xTitle_;
    string yTitle_;
    vector<pair<double, double>> data_;
};

#endif // CSVMODEL_H

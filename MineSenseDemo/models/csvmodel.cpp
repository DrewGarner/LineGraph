#include "csvmodel.h"

CsvModel::CsvModel(string address, string xTitle, string yTitle)
    :address_(address), xTitle_(xTitle), yTitle_(yTitle)
{
}

string CsvModel::getAddress()
{
    return address_;
}

string CsvModel::getXTitle()
{
    return xTitle_;
}

string CsvModel::getYTitle()
{
    return yTitle_;
}

pair<double, double> CsvModel::getData(size_t index)
{
    if(index >= data_.size())
        return make_pair(0,0);
    return data_[index];
}

vector<pair<double,double>> CsvModel::getAllData()
{
    return data_;
}

void CsvModel::setAdress(string a)
{
    address_ = a;
}

void CsvModel::setXTitle(string t)
{
    xTitle_ = t;
}

void CsvModel::setYTitle(string t)
{
    yTitle_ = t;
}

void CsvModel::setData(size_t index, double x, double y)
{
    if(index >= data_.size())
        return;
    data_[index].first = x;
    data_[index].second = y;
}

void CsvModel::setX(size_t index, double x)
{
    if(index >= data_.size())
        return;
    data_[index].first = x;
}

void CsvModel::setY(size_t index, double y)
{
    if(index >= data_.size())
        return;
    data_[index].second = y;
}

void CsvModel::insertData(size_t index, double x, double y)
{
    if(index >= data_.size())
        return;
    vector<pair<double, double>>::iterator it = data_.begin();
    data_.insert(it + index, make_pair(x, y));
}

void CsvModel::addData(double x, double y)
{
    data_.push_back(make_pair(x, y));
}

void CsvModel::removeData(size_t index)
{
    if(index >= data_.size())
        return;
    vector<pair<double, double>>::iterator it = data_.begin();
    data_.erase(it + index);
}

void CsvModel::clearData()
{
    data_.clear();
}

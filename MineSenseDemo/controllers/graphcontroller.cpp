#include "graphcontroller.h"

using namespace std;

GraphController::GraphController(QObject *parent, QQmlContext *view, CsvModel *model) :
    QObject(parent), view_(view), model_(model)
{
}

void GraphController::loadData(QString address)
{
    model_ = CsvFileHandler::loadFile(address.toStdString());
    vector<pair<double,double>> modelData = model_->getAllData();
    dataList_.clear();
    for (auto it = modelData.begin() ; it != modelData.end(); ++it)
    {
        double x = ((pair<double,double>)*it).first;
        double y = ((pair<double,double>)*it).second;
        dataList_.append(new DataObject(x, y));
    }
    QStringList dataTitle;
    dataTitle.append(QString::fromStdString(model_->getXTitle()));
    dataTitle.append(QString::fromStdString(model_->getYTitle()));
    view_->setContextProperty("dataModel", QVariant::fromValue(dataList_));
    view_->setContextProperty("dataTitle", QVariant::fromValue(dataTitle));
}

void GraphController::saveData(QString address)
{
    if(model_ == 0)
    {
        return;
    }
    model_->setAdress(address.toStdString());
    model_->clearData();
    for (auto it = dataList_.begin() ; it != dataList_.end(); ++it)
    {
        double x = ((DataObject*)*it)->x();
        double y = ((DataObject*)*it)->y();
        model_->addData(x, y);
    }
    CsvFileHandler::saveFile(model_);
}

void GraphController::setData(size_t i, qreal x, qreal y)
{
    if(i >= dataList_.size())
        return;
    DataObject *data = ((DataObject*)dataList_[i]);
    if(x == x) //check for NaN
        data->setX(x);
    if(y ==y) //check for NaN
        data->setY(y);
    if(i == 0 ||
            i == dataList_.count() - 1 ||
            data->x() < ((DataObject*)dataList_[i-1])->x() ||
            data->x() > ((DataObject*)dataList_[i+1])->x())
    {
        dataList_.removeAt(i);
        i = 0;
        while(i < dataList_.count() && ((DataObject*)dataList_[i])->x() < data->x())
        {
            i++;
        }
        if(i < dataList_.count() - 1)
        {
            dataList_.insert(i, data);
        }
        else
        {
            dataList_.push_back(data);
        }
    }
    view_->setContextProperty("dataModel", QVariant::fromValue(dataList_));
}


void GraphController::shiftData(size_t i, qreal v)
{
    if(i < 0 || i >= dataList_.length())
        return;
    ((DataObject*)dataList_[i])->setY(((DataObject*)dataList_[i])->y() + v);
    view_->setContextProperty("dataModel", QVariant::fromValue(dataList_));
}

#include "csvfilehandler.h"

CsvFileHandler::CsvFileHandler()
{
}

CsvModel* CsvFileHandler::loadFile(string address)
{
    ifstream file;
    string   line;
    string   xTitle, yTitle;
    CsvModel *model = new CsvModel(address);
    file.open(address);
    if(!file.good())
    {
        cerr<<"failed to open file "<< file << endl;
        return model;
    }
    getline(file, line);
    istringstream isst(line);
    getline(isst, xTitle, ',');
    getline(isst, yTitle, ',');
    model->setXTitle(xTitle);
    model->setYTitle(yTitle);
    while(getline(file, line))
    {
        istringstream iss(line);
        double x, y;
        char delim;
        while(iss>>x>>delim>>y)
        {
            model->addData(x, y);
        }
    }
    return model;
}

void CsvFileHandler::saveFile(CsvModel *model)
{
    ofstream file;
    file.open(model->getAddress());
    if(!file.good())
    {
        cerr<<"failed to open file "<< file << endl;
        return;
    }
    file<<model->getXTitle()<<','<<model->getYTitle()<<endl;
    vector<pair<double,double>> modelData = model->getAllData();
    for (auto it = modelData.begin() ; it != modelData.end(); ++it)
    {
        double x = ((pair<double,double>)*it).first;
        double y = ((pair<double,double>)*it).second;
        file<<x<<','<<y<<endl;
    }
    file.close();
}

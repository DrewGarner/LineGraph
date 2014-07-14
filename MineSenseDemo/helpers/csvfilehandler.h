#ifndef CSVFILEHANDLER_H
#define CSVFILEHANDLER_H

#include <fstream>
#include <sstream>
#include <iostream>
#include <string>
#include "../models/csvmodel.h"

using namespace std;

/**
 * CsvFileHandler is a static class that gives functtions to
 * read and write csv files
 */
class CsvFileHandler
{
public:
    /*
     * Constructor is not needed
     */
    CsvFileHandler();
    /*
     * Purpose: Parse a csv file
     * Parameters: address - absolute address of file to beread
     * returns: CsvModel* - Pointer to a model object filled with sata from the file
     */
    static CsvModel* loadFile(string address);
    /*
     * Purpose: To write data to a csv file
     * Paramters: model - model with data to be written
     * returns: n/a
     */
    static void saveFile(CsvModel *model);
};

#endif // CSVFILEHANDLER_H

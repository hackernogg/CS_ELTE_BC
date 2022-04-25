#ifndef STORE_H
#define STORE_H
#include "Department.h"
#include <iostream>
#include <fstream>
#include <vector>

using namespace std;


class Store
{
    public:
        Store(const string &foodsFile, const string &techFile);
        ~Store();

        Department* foods;
        Department* technical;


    private:
};

#endif // STORE_H

#ifndef DEPARTMENT_H
#define DEPARTMENT_H
#include <iostream>
#include <fstream>
#include <vector>
#include "Product.h"

using namespace std;

class Department
{
    public:
        Department(const string &filename);
        void takeOut(Product *p);
        ~Department();

        vector<Product *> stock;


    private:
};

#endif // DEPARTMENT_H

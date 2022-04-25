#ifndef CUSTOMER_H
#define CUSTOMER_H

#include "Store.h"
#include <iostream>
#include <fstream>
#include <vector>

using namespace std;


class Customer
{
    public:
        Customer(const string &filename);
        ~Customer();

        string purchase(Store &store);

    private:
        string name;
        vector<string> shoplist;

        vector<Product *> cart;

        bool linSearch(string pName, Department* dept, Product* &p);
        bool minSearch(string pName, Department* dept, Product* &p);
};

#endif // CUSTOMER_H

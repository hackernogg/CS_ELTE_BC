#include "Department.h"


Department::Department(const string &filename)
{
    std::ifstream f;
    f.open(filename.c_str());

    std::string pName;
    int price;

    while (f>>pName>>price)
    {
        Product *p = new Product(pName, price);
        stock.push_back(p);
    }
}

void Department::takeOut(Product *p)
{
    bool l = false;
    int ind;

    for (int i = 0; !l&&i<stock.size(); ++i)
    {
        l = (stock[i] == p);
        ind = i;
    }
    if (l)
    {
        stock.erase(stock.begin() + ind);
    }
}

Department::~Department()
{
    for (Product *p : stock)
        delete p;
    //for (int i = 0 ; i <stock.size(); ++i)
    //  delete stock[i];
    //same
}

#include "Customer.h"
#include <sstream>

Customer::Customer(const string &filename)
{
    ifstream f;
    f.open(filename.c_str());

    f>>name;

    string pName;
    while (f >> pName)
    {
        shoplist.push_back(pName);
    }
}
bool Customer::linSearch(string pName, Department* dept, Product* &p)
{
    bool l = false;
    for (int i = 0; !l && i <dept-> stock.size(); ++i)
    {
        if(dept -> stock[i] ->getName() == pName)
        {
            l = true;
            p = dept -> stock[i];
        }
    }
    return l;
}
bool Customer::minSearch(string pName, Department* dept, Product* &p)
{
    bool l = false;
    int minPrice ;
    for(Product *prod :dept ->stock)
    {
        if (pName != prod->getName())
        {
            continue;
        }

        if(l)
        {
            if(minPrice > prod->getPrice())
            {
                minPrice = prod->getPrice();
                p = prod;
            }
        }
        else
        {
            l = true;
            minPrice = prod->getPrice();
            p = prod;
        }
    }
    return l;
}
string Customer::purchase(Store &store)
{
    stringstream ss;
    for (int i = 0; i <shoplist.size();++i)
    {
        Product *p;
        bool l = linSearch(shoplist[i], store.foods, p);
        if(l)
        {
            cart.push_back(p);
            store.foods ->takeOut(p);
            ss << p->getName() << " " << p->getPrice() << endl;
        }
    }
    for (int i = 0; i <shoplist.size();++i)
    {
        Product *p;
        bool l = minSearch(shoplist[i], store.technical, p);
        if(l)
        {
            cart.push_back(p);
            store.technical ->takeOut(p);
            ss << p->getName() << " " << p->getPrice() << endl;
        }
    }
    return ss.str(); // to string
}

Customer::~Customer()
{
    //dtor
}

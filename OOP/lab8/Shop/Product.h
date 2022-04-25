#ifndef PRODUCT_H
#define PRODUCT_H
#include <iostream>

using namespace std;


class Product
{
    public:
        Product(const string n, int p) : name(n), price(p) {};
        string getName() const { return name;}
        int getPrice() const { return price;}

        bool operator==(const Product* p)
        {
            return p->getName() == name && getPrice() == price;
        }

    private:
        string name;
        int price;
};

#endif // PRODUCT_H

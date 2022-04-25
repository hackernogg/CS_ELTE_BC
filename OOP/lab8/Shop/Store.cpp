#include "Store.h"

Store::Store(const string &foodsFile, const string &techFile)
{
    foods = new Department(foodsFile);
    technical = new Department(techFile);
}

Store::~Store()
{
    delete foods;
    delete technical;
}

#include "Plant.h"

Rose* Rose::_instance = nullptr;

Rose* Rose::getInstance()
{
    if (_instance == nullptr)
    {
        _instance = new Rose();
    }
    return _instance;
}

void Rose::destroy()
{
    if (_instance != nullptr )
    {
        delete _instance;
    }
    _instance = nullptr;
}



Potatoe* Potatoe::_instance = nullptr;

Potatoe* Potatoe::getInstance()
{
    if (_instance == nullptr)
    {
        _instance = new Potatoe();
    }
    return _instance;
}
void Potatoe::destroy()
{
    if (_instance != nullptr )
    {
        delete _instance;
    }
    _instance = nullptr;
}

//Author:   Tibor Gregorics
//Date:     2017.12.15.
//Title:    implementation of classes of groundtypes (with Visitor design pattern)

#include "ground.h"
#include "creature.h"

using namespace std;

// implementation of class Sand
Sand* Sand::_instance = nullptr;
Sand* Sand::instance()
{
    if(_instance == nullptr) {
        _instance = new Sand();
    }
    return _instance;
}
void Sand::destroy()
{
	if ( nullptr!=_instance )
	{
		delete _instance;
		_instance = nullptr;
	}
}

Ground* Sand::transmute(Greenfinch *p)
{
    p->changePower(-2);
    return this;
}

Ground* Sand::transmute(DuneBeetle *p)
{
    p->changePower(3);
    return this;
}

Ground* Sand::transmute(Squelchy *p)
{
    p->changePower(-5);
    return this;
}

// implementation of class Grass
Grass* Grass::_instance = nullptr;
Grass* Grass::instance()
{
    if(_instance == nullptr) {
        _instance = new Grass();
    }
    return _instance;
}
void Grass::destroy()
{
	if ( nullptr!=_instance )
	{
		delete _instance;
		_instance = nullptr;
	}
}

Ground* Grass::transmute(Greenfinch *p)
{
    p->changePower(1);
    return this;
}

Ground* Grass::transmute(DuneBeetle *p)
{
    p->changePower(-2);
    return Sand::instance();
}

Ground* Grass::transmute(Squelchy *p)
{
    p->changePower(-2);
    return Marsh::instance();
}

// implementation of class Marsh
Marsh* Marsh::_instance = nullptr;
Marsh* Marsh::instance()
{
    if(_instance == nullptr) {
        _instance = new Marsh();
    }
    return _instance;
}
void Marsh::destroy()
{
	if ( nullptr!=_instance )
	{
		delete _instance;
		_instance = nullptr;
	}
}

Ground* Marsh::transmute(Greenfinch *p)
{
    p->changePower(-1);
    return Grass::instance();
}

Ground* Marsh::transmute(DuneBeetle *p)
{
    p->changePower(-4);
    return Grass::instance();
}

Ground* Marsh::transmute(Squelchy *p)
{
    p->changePower(6);
    return this;
}

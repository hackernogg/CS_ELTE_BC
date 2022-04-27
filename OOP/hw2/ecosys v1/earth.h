#ifndef EARTH_H
#define EARTH_H
#include <iostream>

using namespace std;

class earth
{
    public:
        int getEarthType() const {return _typeInd;}
        earth(int i = 0) : _typeInd(i){}
        bool isnonRad() const {return _typeInd == 0;}
        earth changeType(earth theEarth,int a, int b);
    protected:
        int _typeInd;

};

class Alpha : public earth
{
public:
    Alpha(int i = 1) :earth(i){}
};
class Delta : public earth
{
public:
    Delta(int i = 2) :earth(i){}
};
class nonRad : public earth
{
public:
    nonRad(int i = 0) :earth(i){}
};
#endif // EARTH_H

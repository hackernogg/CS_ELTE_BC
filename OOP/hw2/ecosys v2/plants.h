#ifndef PLANTS_H
#define PLANTS_H

#include <iostream>
#include <vector>
#include <tuple>
#include "earth.h"

using namespace std;

class plants
{
    protected:
        string _name;
        int _level;
        tuple <int,int> _needRad;
        plants(const string &str, int i) :_name(str), _level(i) {}
    public:
        virtual void changeLevel(earth theEarth){}
        string getName() const {return _name;}
        int getLevel() const {return _level;}
        tuple<int,int> getNeedRad() const {return _needRad;}
        virtual bool isAlive() const {return _level > 0;}
        virtual void changeNeedRad() {}


};

class Womroot : public plants
{

    public:
        bool isAlive() const override {return (_level>0 && _level <=10);}
        Womroot(const string &str, int e) : plants(str,e) {}
        void changeLevel(earth theEarth) override;
        void changeNeedRad() override;

};
class Witroot : public plants
{

    public:
        Witroot(const string &str, int e) : plants(str,e) {}
        void changeLevel(earth theEarth) override;
        void changeNeedRad() override;

};
class Worroot : public plants
{

    public:
        Worroot(const string &str, int e) : plants(str,e) {}
        void changeLevel(earth theEarth) override;
        void changeNeedRad() override;

};

#endif // PLANTS_H

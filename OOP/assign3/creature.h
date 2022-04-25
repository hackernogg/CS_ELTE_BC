//Author:   Tibor Gregorics
//Date:     2017.12.15.
//Title:    classes of creatures

#pragma once

#include <string>
#include "ground.h"

// class of the abstract creatures
class Creature{
protected:
    std::string _name;
    int _power;
    Creature (const std::string &str, int e = 0) :_name(str), _power(e) {}
public:
    std::string name() const { return _name; }
    bool alive() const { return _power > 0; }
    void changePower(int e) { _power += e; }
    virtual void transmute(Ground* &ground) = 0;
    virtual ~Creature () {}
};

// class of Greenfinches
class Greenfinch : public Creature {
public:
    Greenfinch(const std::string &str, int e = 0) : Creature(str, e){}
    void transmute(Ground* &ground) override {
        ground = ground->transmute(this);
    }
};

// class of Dune beetles
class DuneBeetle : public Creature {
public:
    DuneBeetle(const std::string &str, int e = 0) : Creature(str, e){}
    void transmute(Ground* &ground) override {
        ground = ground->transmute(this);
    }
};

// class of Squelchies
class Squelchy : public Creature {
public:
    Squelchy(const std::string &str, int e = 0) : Creature(str, e){}
    void transmute(Ground* &ground) override{
        ground = ground->transmute(this);
    }
};


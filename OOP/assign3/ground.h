//Author:   Tibor Gregorics
//Date:     2017.12.15.
//Title:    classes of groundtypes (with Visitor design pattern)

#pragma once

#include <string>

class Greenfinch;
class DuneBeetle;
class Squelchy;

// class of the abstract grounds
class Ground{
public:
    virtual Ground* transmute(Greenfinch *p) = 0;
    virtual Ground* transmute(DuneBeetle *p) = 0;
    virtual Ground* transmute(Squelchy   *p) = 0;
    virtual ~Ground() {}
};

// class of sand
class Sand : public Ground
{
public:
    static Sand* instance();
    Ground* transmute(Greenfinch *p) override;
    Ground* transmute(DuneBeetle *p) override;
    Ground* transmute(Squelchy   *p) override;
    static void destroy() ;
protected:
    Sand(){}
private:
    static Sand* _instance;
};

// class of grass
class Grass : public Ground
{
public:
    static Grass* instance();
    Ground* transmute(Greenfinch *p) override;
    Ground* transmute(DuneBeetle *p) override;
    Ground* transmute(Squelchy   *p) override;
    static void destroy() ;
protected:
    Grass(){}
private:
    static Grass* _instance;
};

// class of marsh
class Marsh : public Ground
{
public:
    static Marsh* instance();
    Ground* transmute(Greenfinch *p) override;
    Ground* transmute(DuneBeetle *p) override;
    Ground* transmute(Squelchy   *p) override;
    static void destroy() ;
protected:
    Marsh(){}
private:
    static Marsh* _instance;
};

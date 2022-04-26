#ifndef PLANT_H
#define PLANT_H

#include <iostream>
#include <vector>
class Plant
{
    public:
        int getRipeningTime() const { return _ripeningTime;}
        virtual bool isVegetable() const { return false;}


    protected:
        int _ripeningTime;
        ///Plant() {}
        Plant(int ripTime) : _ripeningTime(ripTime) {}
};

class Vegetable : public Plant
{
protected:
    ///int _ripeningTime;
    Vegetable(int i) : Plant(i) {}
public:
    bool isVegetable() const override { return true;}
};

class Flower : public Plant
{
protected:
    ///int _ripeningTime;
    Flower(int i) : Plant(i) {}
};



class Potatoe : public Vegetable
{
public:
    static Potatoe* getInstance();
    static void destroy();
private:
    Potatoe() : Vegetable(4) {}
    static Potatoe* _instance;
};

class Rose : public Flower
{
public:
    static Rose* getInstance();
    static void destroy();
private:
    Rose() : Flower(3) {}
    static Rose* _instance;
};


//Potatoe p();
//p.nonstatic();
//
//Potatoe.getInstance();






#endif // PLANT_H

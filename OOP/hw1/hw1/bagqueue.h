#ifndef BAGQUEUE_H
#define BAGQUEUE_H
#include <string>
#include <iostream>
#include <vector>
#include "read.hpp"


using namespace std;
inline bool valid(int a){return true;}

struct Bag
{
    int element;
    int frequency;

    //constructors
    Bag(){};
    Bag(int e,int f):element(e),frequency(f){}

     friend std::istream& operator>>(std::istream& s, Bag& e)
    {
        e.element=read<int>("element:","Integer is needed!",valid);
        std::cout<<"frequency:";
        s>>e.frequency;
        return s;
    }
    friend std::ostream& operator<<(std::ostream& s, const Bag& e)
    {
        s<<"element: "<<e.element<<" frequency: "<<e.frequency<<" ";
        return s;
    }
};

class BagQueue
{
    public:
        void add(Bag a);
        friend std::ostream& operator<<(std::ostream& s, const BagQueue& q);
        void rem();
        Bag MaxEle();
        Bag GetFre(int e);


    private:
        std::vector<Bag> _vec;
};

#endif // BAGQUEUE_H

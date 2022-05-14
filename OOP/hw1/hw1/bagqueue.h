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
        e.frequency=read<int>("frequency:","Integer is needed!",valid);
        return s;
    }
    friend std::ostream& operator<<(std::ostream& s, const Bag& e)
    {
        s<<"element: "<<e.element<<" frequency: "<<e.frequency<<" ";
        return s;
    }
    ///for testing
    bool operator==(const Bag& b)
    {
        return (element==b.element && frequency==b.frequency);
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
        bool isEmpty() {return _vec.size()==0;}

        ///Methods for testing
        friend std::ostream& operator<<(std::ostream& s, const BagQueue& q); ///print a line
        unsigned int getLength() const {return _vec.size();}
        unsigned int getCapacity() const {return _vec.capacity();}
        std::vector<Bag> getItems() const;
        //int getMaxindex() const {return maxindex();}


    private:
        std::vector<Bag> _vec;
};

#endif // BAGQUEUE_H

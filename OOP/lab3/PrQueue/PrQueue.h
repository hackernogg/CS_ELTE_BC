#ifndef PRIORSOR_H_INCLUDED
#define PRIORSOR_H_INCLUDED
#include <string>
#include <iostream>
#include <vector>
#include "read.hpp"

///function for controlled data reading
///To avoid multiple declaration, it is inline.
inline bool valid(int a){return true;}

struct Item
{
    ///public attributes
    int pr;
    std::string data;

    ///constructors
    Item() {};
    Item(int p,std::string s):pr(p), data(s) {}

    friend std::istream& operator>>(std::istream& s, Item& e)
    {
        e.pr=read<int>("Priority:","Integer is needed!",valid);
        std::cout<<"Data:";
        s>>e.data;
        return s;
    }
    friend std::ostream& operator<<(std::ostream& s, const Item& e)
    {
        s<<"priority: "<<e.pr<<" data: "<<e.data<<" ";
        return s;
    }

    ///for testing
    bool operator==(const Item& b)
    {
        return (pr==b.pr && data==b.data);
    }
};

class PrQueue
{
    public:
        enum PrQueueError{EMPTY_PRQUEUE};

        ///PrQueue(); //Not needed
        ///~PrQueue() {} //Not needed

        void add(Item a);
        Item remMax() throw (PrQueueError); ///take out the item with the highest priority
        Item max() const throw (PrQueueError); ///get the item with the highest priority
        bool isEmpty() {return _vec.size()==0;}

        ///Methods for testing
        friend std::ostream& operator<<(std::ostream& s, const PrQueue& q); ///print a line
        unsigned int getLength() const {return _vec.size();}
        unsigned int getCapacity() const {return _vec.capacity();}
        std::vector<Item> getItems() const;
        int getMaxindex() const {return maxindex();} ///maxindex is private, cannot be called outside

    private:
        std::vector<Item> _vec; ///array implemented as a vector
        int maxindex() const; ///index of the maximal element

};


#endif // PRIORSOR_H_INCLUDED

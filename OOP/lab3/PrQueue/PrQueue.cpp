#include "prqueue.h"

using namespace std;

void PrQueue::add(Item a)
{
    _vec.push_back(a);
}

Item PrQueue::remMax() throw (PrQueueError)
{
    if(_vec.size()==0) throw EMPTY_PRQUEUE;
    int ind=maxindex();
    Item newItem=_vec[ind];
    _vec[ind]=_vec[_vec.size()-1]; ///Last item is put to the place of the taken element
    _vec.pop_back();
    return newItem;
}

Item PrQueue::max() const throw (PrQueueError)
{
    if(_vec.size()==0) throw EMPTY_PRQUEUE;
    int ind=maxindex();
    return Item(_vec[ind]);
}

ostream& operator<<(std::ostream& s, const PrQueue& q)
{
    s<<"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";
    s<<"Number of elements: "<<q._vec.size()<<"\nContent: "<<endl;
    for(unsigned i=0; i<q._vec.size(); ++i){
        s<<" ("<<q._vec[i].pr<<","<<q._vec[i].data<<")";
    }
    s<<"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n";
    return s;
}

int PrQueue::maxindex() const
{
    int ind=0;
    for(unsigned i=1; i<_vec.size(); ++i)
    {
        if(_vec[i].pr>_vec[ind].pr)
        {
            ind=i;
        }
    }
    return ind;
}

vector<Item> PrQueue::getItems() const
{
    vector<Item> v;
    for(unsigned i=0; i<_vec.size(); ++i)
        v.push_back(_vec[i]);
    return v;
}

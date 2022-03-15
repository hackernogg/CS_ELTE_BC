#include "bagqueue.h"

using namespace std;

void BagQueue::add(Bag a)
{
    _vec.push_back(a);
}
void BagQueue::rem()
{
    _vec.pop_back();
}
Bag BagQueue::MaxEle()
{
    int ind=0;
    for(unsigned i=1; i<_vec.size(); ++i)
    {
        if(_vec[i].element>_vec[ind].element)
        {
            ind=i;
        }
    }
    return Bag(_vec[ind]);
}
Bag BagQueue::GetFre(int e)
{
    int ind=0;
    for(unsigned i =1;i<_vec.size();++i)
    {
        if(_vec[i].element==e){
            ind = i;
        }
    }
    return Bag(_vec[ind]);
}

ostream& operator<<(std::ostream& s, const BagQueue& q)
{
    s<<"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";
    s<<"Number of elements: "<<q._vec.size()<<"\nContent: "<<endl;
    for(unsigned i=0; i<q._vec.size(); ++i){
        s<<" ("<<q._vec[i].element<<","<<q._vec[i].frequency<<")";
    }
    s<<"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n";
    return s;
}

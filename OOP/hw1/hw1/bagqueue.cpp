#include "bagqueue.h"

using namespace std;

bool checkIsIn(vector<Bag> b,Bag a)
{
    for(int i = 0; i<b.size(); ++i)
    {
        if(a.element==b[i].element)
        {
            return false;
        }
    }
    return true;
}

void BagQueue::add(Bag a)
{
    if(checkIsIn(_vec,a))
    {
        _vec.push_back(a);
    }
    else
    {
        cout<< "The element is already exist";
    }

}
void BagQueue::rem()
{
    if(_vec.size()>0){
        _vec.pop_back();
    }
    else
    {
        cout << "It is already empty";
    }

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
    bool l = false;
    int i = 0;
    for(;l==false &&i<_vec.size();)
    {
        if(_vec[i].element==e)
        {
            l=true;
            ind = i;
        }
        else
        {
            i=i+1;
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

vector<Bag> BagQueue::getItems() const
{
    vector<Bag> v;
    for(unsigned i=0; i<_vec.size(); ++i)
        v.push_back(_vec[i]);
    return v;
}

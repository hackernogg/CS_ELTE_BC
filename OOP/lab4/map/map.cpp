#include "map.h"

using namespace std;

void Map::insert(Item e) throw (std::exception)
{
    pair<bool,int> out=logSearch(e.key);
    ///<6, "hghjf">
    ///<2,4,5,7,8,9,11, _> key = 6
    ///<false, 3>
    ///i = 6; i>= 3; i--
    ///<2, 4, 5, 6, 7, 8, 9, 11> shifting right
    if (!out.first)///size = 8
    {
        _vec.resize(_vec.size()+1);
        for (int i=_vec.size()-2;i>=out.second;i--) ///unsigned int cannot be used, otherwise (i-2) may become very large :)
        {
            _vec[i+1]=_vec[i];
        }
        _vec[out.second] = e;
    }
    else
    {
        throw ExistingKeyException();
    }
}

void Map::erase(int key) throw (std::exception)
{
    std::pair<bool,int> out=logSearch(key);
    ///<2, 4, 5, 6, 7, 8, 9, 11> key = 6
    ///i = 4; i < 8; ++i
    ///<2, 4, 5, 7, 8, 9, 11>
    ///<true, 3> shifting left
    if (out.first)
    {
        for (unsigned int i=out.second+1;i<_vec.size();i++)
        {
            _vec[i-1]=_vec[i];
        }
        _vec.pop_back();
    }
    else
    {
        throw NonExistingKeyException();
    }
}

bool Map::isIn(int key) const
{
    return logSearch(key).first;
    ///<true/false, ind>
}

std::string &Map::operator[](int key) throw (std::exception)
{
    pair<bool,int> out=logSearch(key);
    ///Map m;
    ///<(1, "a"), (3, "b"), (7, "c"), (8, "d")>
    ///m[3] = "b"
    ///key = 3
    ///<true, 1>
    if (out.first)
    {
        return _vec[out.second].data;
    }
    else
    {
        throw NonExistingKeyException();
    }
}

pair<bool,int> Map::logSearch(int key) const
{
    bool l=false;
    int lb=0; ///vector numbering starts at 0
    int ub=_vec.size()-1; /// vector numbering finishes at size()-1
    int ind;///<2,4,5,7,8,9, 11> key = 6
    ///lb = 0; ub = 6; ind = 3;
    ///lb = 0; ub = 2; ind = 1;
    ///lb = 2; ub = 2; ind = 2;
    ///lb = 3; ub = 2; l = false
    while (!l && lb <= ub)
    {
        ind=(lb+ub)/2;
        if (_vec[ind].key>key) { ub = ind-1; }
        else if (_vec[ind].key<key) { lb = ind+1; }
        else { l= true; }
    }
    if (!l)
    {
        ind = lb;
    }
    return pair<bool,int>(l,ind);
}


ostream& operator<<(std::ostream& s, const Map& m)
{
    s<<"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";
    s<<"Number of elements: "<<m._vec.size()<<"\nContent: "<<endl;
    for(unsigned i=0; i<m._vec.size(); ++i){
        s<<" "<<m._vec[i];///Item e;
    }
    s<<"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n";
    return s;
}

std::vector<Item> Map::getItems() const
{
    std::vector<Item> v;
    for(unsigned i=0; i<_vec.size(); ++i)
        v.push_back(_vec[i]);
    return v;
}

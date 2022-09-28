#include <iostream>
#include "library/summation.hpp"
#include "library/maxsearch.hpp"
#include "library/seqinfileenumerator.hpp"
#include "library/stringstreamenumerator.hpp"
using namespace std;

struct Prog
{
    string name;
    double mark;

    friend istream& operator>>(istream &is, Prog &p)
    {
        is>>p.name>>p.mark;
        return is;
    }
};
//{(numofProg, isHaskell)}
struct sumProg
{
    int numProg;
    bool isHaskell;

    sumProg() {}
    sumProg(int n, bool b) : numProg(n),isHaskell(b) {}
};

class lineSum : public Summation<Prog,sumProg>
{
    sumProg func(const Prog& e) const override {return sumProg(1,e.name=="Haskell");}
    sumProg neutral() const override {return sumProg(0,false);}
    sumProg add(const sumProg& a, const sumProg& b) const override {
        return sumProg(a.numProg+b.numProg,a.isHaskell||b.isHaskell);
    }
};


struct rankInfo
{
    string name;
    string month;
    int numProg;
    bool isHaskell;

    friend istream& operator>>(istream &is, rankInfo &r);
};

istream& operator>>(istream &is, rankInfo &r)
{
    string line;
    getline(is, line);
    stringstream ss(line);

    ss>>r.name>>r.month;

    lineSum pr;

    StringStreamEnumerator<Prog> ssenor(ss);

    pr.addEnumerator(&ssenor);

    pr.run();

    r.numProg = pr.result().numProg;
    r.isHaskell = pr.result().isHaskell;

    return is;
}

class findMostProg : public MaxSearch<rankInfo,int>
{
    int func(const rankInfo& e) const override {return e.numProg;}
    bool  cond(const rankInfo& e) const override { return e.isHaskell;}
};
int main()
{
    try{
        string filename;
        filename = "input.txt";

        findMostProg pr;
        SeqInFileEnumerator<rankInfo> enor(filename);
        pr.addEnumerator(&enor);

        pr.run();

        cout<<pr.optElem().name;
        if(pr.optElem().name=="")
        {
            cout<<"Can not find, or empty file";
        }


    }catch(SeqInFileEnumerator<rankInfo>:: Exceptions ex)
    {
        cout<< "File not found !"<<endl;
        return 1;
    }
    return 0;
}

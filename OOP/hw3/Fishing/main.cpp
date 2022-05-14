#include <iostream>
#include "library/summation.hpp"
#include "library/stringstreamenumerator.hpp"
#include "library/selection.hpp"
#include "library/seqinfileenumerator.hpp"
using namespace std;

struct Fish{
    string type;
    int length;

    friend istream& operator>>(istream &is, Fish &f)
    {
        is >> f.type >> f.length;
        return is;
    }

};

struct sumResult{
    bool carp;

    sumResult() {}
    sumResult(bool b) : carp(b){}
};

class lineSum : public Summation<Fish, sumResult>
{
    sumResult func(const Fish& e) const override{return sumResult(e.type == "carp");}
    sumResult neutral() const override { return sumResult(false);}
    sumResult add( const sumResult& a, const sumResult& b) const override
    {
        return sumResult(a.carp || b.carp);
    }
};

struct Angler{
    string name;
    string matchID;
    bool carp;

    friend istream& operator>>(istream &is, Angler &a);
};

istream& operator>>(istream &is, Angler &a)
{
    string line;
    getline(is, line);
    stringstream ss(line);

    ss>>a.name >> a.matchID;

    lineSum pr;

    StringStreamEnumerator<Fish> ssenor(ss);

    pr.addEnumerator(&ssenor);

    pr.run();

    a.carp = pr.result().carp;

    return is;

}

class outPuttWithCarp : public Summation<Angler, ostream>
{
public:
    outPuttWithCarp(ostream *o) : Summation<Angler, ostream>::Summation(o) {}
protected:
    std::string func(const Angler& e) const override
    {
        ostringstream oss;
        oss <<"Match has crap : "<<e.matchID <<" Angler: "<<e.name<<endl;
        return oss.str();
    }
    bool cond(const Angler& e) const { return e.carp == true; }
};

int main()
{
    try{
        string filename;
        filename = "input.txt";

        outPuttWithCarp pr(&cout);
        SeqInFileEnumerator<Angler> enor(filename);
        pr.addEnumerator(&enor);

        pr.run();


    }catch(SeqInFileEnumerator<Angler>:: Exceptions ex)
    {
        cout << "File not found !"<<endl;
        return 1;
    }
    return 0;
}

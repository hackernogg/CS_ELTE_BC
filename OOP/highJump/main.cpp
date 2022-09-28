#include <iostream>
#include "library/summation.hpp"
#include "library/seqinfileenumerator.hpp"
#include "library/stringstreamenumerator.hpp"
#include "library/linsearch.hpp"

using namespace std;

struct Game {
    string name;
    int rank;

    friend istream& operator>>(istream &is, Game &g)
    {
        is >> g.name >> g.rank;
        return is;
    }
};
///LinSearch
///MaxSearch
///Counting

struct sumResult
{
    bool highJump;///linSearch
    int bestRank;///MaxSearch
    int silverMedals;///Count

    sumResult() {}
    sumResult(bool b, int bR, int sM) : highJump(b), bestRank(bR), silverMedals(sM) {}
};

class lineSum : public Summation<Game, sumResult>
{
    sumResult func(const Game& e) const override{return sumResult(e.name == "highjump", e.rank, e.rank == 2 ? 1 : 0);}
    sumResult neutral() const override { return sumResult(false,99999,0);}
    sumResult add( const sumResult& a, const sumResult& b) const override
    {
        return sumResult(a.highJump || b.highJump , a.bestRank < b.bestRank ? a.bestRank : b.bestRank, a.silverMedals + b.silverMedals);
    }
};

struct Contestant{
    string name;
    string school;
    bool highJump;
    int bestrank;
    int silvers;

    friend istream& operator>>(istream &is, Contestant &c);
};
istream& operator>>(istream &is, Contestant &c)
{
    string line;
    getline(is, line);
    stringstream ss(line);

    ss>>c.name>>c.school;

    lineSum pr;

    StringStreamEnumerator<Game> ssenor(ss);

    pr.addEnumerator(&ssenor);

    pr.run();

    c.highJump = pr.result().highJump;
    c.bestrank = pr.result().bestRank;
    c.silvers = pr.result().silverMedals;

    return is;
}
class findHighJumper : public LinSearch<Contestant>
{
    bool cond(const Contestant& e) const override
    {
        return e.highJump && e.bestrank== 2;
    }
};
int main()
{
    try{
        string filename;
        filename = "input.txt";

        findHighJumper pr;
        SeqInFileEnumerator<Contestant> enor(filename);
        pr.addEnumerator(&enor);

        pr.run();

        if(pr.found())
        {
            cout<< pr.elem().name <<" from " << pr.elem().school << " has participated in highjump and has the best rank as silver, and no. of silvers is: " << pr.elem().silvers<<endl;
        }
        else
        {
            cout << "There was no such hightJumper\n"<<endl;
        }
    }catch(SeqInFileEnumerator<Contestant>:: Exceptions ex)
    {
        cout<< "File not found !"<<endl;
        return 1;
    }
    return 0;
}

#include <iostream>
#include "library/summation.hpp"
#include "library/seqinfileenumerator.hpp"
#include "library/stringstreamenumerator.hpp"
#include "library/maxsearch.hpp"
/*
who is the best student with the best average grade
*/
using namespace std;

struct Result {
    int sum;
    int count;

    Result() {}
    Result(int s, int c) :sum(s), count(c) {}
};

struct Student{
    string name;
    double avg;

    friend istream& operator>>(istream& is, Student &s);

};

class Average : public Summation<int, Result>
{
    Result func(const int& e) const override {return Result(e,1);}
    Result neutral() const override {return Result(0,0);}
    Result add( const Result& a, const Result& b) const override {return Result(a.sum + b.sum, a.count + b.count);}
};
istream& operator>>(istream& is, Student &s)
{
    string line;
    getline(is, line, '\n');
    stringstream ss(line);
    ss>> s.name;

    Average pr;
    StringStreamEnumerator<int> ssenor(ss);
    pr.addEnumerator(&ssenor);
    pr.run();

    if(pr.result().count > 0)
    {
        s.avg = double(pr.result().sum) / pr.result().count;
    }
    else
    {
        s.avg = 0;
    }
    return is;

};
class maxAvg : public MaxSearch<Student, double>
{
    double func(const Student& e) const override {return e.avg; }
};
int main()
{
    maxAvg pr;

    SeqInFileEnumerator<Student> enor("input.txt");
    pr.addEnumerator(&enor);
    pr.run();

    cout << pr.optElem().name << " " << pr.optElem().avg << endl;
    return 0;
}

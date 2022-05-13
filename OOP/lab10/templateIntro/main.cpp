#include <iostream>
#include "library/summation.hpp"
#include "library/seqinfileenumerator.hpp"
#include "library/intervalenumerator.hpp"
#include "library/counting.hpp"
#include "library/linsearch.hpp"
#include <fstream>
using namespace std;
/*
sum all the numbers in a given file using template class library (even, odd)
*/
/*
Assort evens to a file
*/
/*
calculate factorial of a number
*/
class mySum : public Summation<int>
{
    int func(const int& e) const {return e;}
    int neutral() const override {return 0;}
    int add(const int& a, const int& b) const override {return a+b;}
    //bool cond(const int& e) const override {return e%2==0;}
};
class assort : public Summation<int, ostream>
{
public:
    assort(ostream *o) : Summation<int,ostream>::Summation(o) {}
protected:
    std::string func(const int& e) const override {return to_string(e) + " ";}
    bool cond(const int& e) const { return e % 2 == 0; }
};
class Factorial :public Summation<int>
{
    int func(const int& e) const override {return e;}
    int neutral() const override {return 1;}
    int add( const int& a, const int& b) const override {return a*b;}
};
class myCount : public Counting<int>
{
    bool cond(const int& e) const override {return e % 2 == 0;}
};

class evenSearch :public LinSearch<int>
{
    bool cond(const int& e) const override {return e % 2 == 0;}
};
int main()
{
    /*
    int number = 6;
    Factorial pr;
    IntervalEnumerator enor(2, number);
    pr.addEnumerator(&enor);
    pr.run();

    cout << "the factorial result is : " <<pr.result()<<endl;
    */

    try{
        ofstream f("output.txt");
        //mySum pr; //Identity
        //assort pr(&cout);
        //assort pr(&f);
        //myCount pr;
        evenSearch pr;
        SeqInFileEnumerator<int> enor("input.txt");
        pr.addEnumerator(&enor);
        pr.run();
        if(pr.found())
        {
            cout << pr.elem() <<endl;
        }
        else{
            cout << "can not found"<< endl;
        }

    }catch(SeqInFileEnumerator<int>::Exceptions ex)
    {
        cout << "file not found ! \n";
    }


    return 0;
}

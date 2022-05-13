#include <iostream>
#include "library/summation.hpp"
#include "library/seqinfileenumerator.hpp"
#include "library/enumerator.hpp"
#include "library/maxsearch.hpp"

using namespace std;

struct Mark {
    string name;
    int grade;

    friend istream& operator >>(istream &is, Mark &m)
    {
        is >> m.name >> m.grade;
        return is;
    }
};

struct Result {
    int sum;
    int cnt;

    Result() {}
    Result(int s, int c) : sum(s), cnt(c) {}
};

class Average : public Summation<Mark, Result>
{
private:
    string _name;
public:
    Average(const string &name) :_name(name) {}
protected:
    Result func(const Mark& e) const override {return Result(e.grade,1);}
    Result neutral() const override {return Result(0, 0);}
    Result add( const Result& a, const Result& b) const override { return Result(a.sum + b.sum, a.cnt + b.cnt);}

    bool whileCond(const Mark& current) const override { return current.name == _name; }
    void first() override{}

};

struct Student{
    string name;
    double avg;
};

class StudentEnor : public Enumerator<Student>
{
private:
    SeqInFileEnumerator<Mark>* _f;
    Student _student;
    bool _end;

public:
    StudentEnor(const string &fname) {_f = new SeqInFileEnumerator<Mark>(fname);}
    ~StudentEnor() {delete _f;}
    void first() override {_f->first(); next();}
    void next() override;
    bool end() const override {return _end;}
    Student current() const override {return _student;}
};
void StudentEnor::next()
{
    if(_end = _f->end()) return ;
    _student.name = _f->current().name;
    Average pr(_student.name);
    pr.addEnumerator(_f);

    pr.run();

    if (pr.result().cnt > 0)
    {
        _student.avg = double(pr.result().sum)/pr.result().cnt;
    }
    else
    {
        _student.avg = 0.0;
    }
}

class bestStudent : public MaxSearch<Student, double>
{
protected:
    double func(const Student& e) const override {return e.avg;}
};

int main()
{
    try{
        bestStudent pr;
        StudentEnor enor("input.txt");

        pr.addEnumerator(&enor);

        pr.run();

        if(pr.found())
        {
            cout <<"Best student is :" << pr.optElem().name << " With avg: " << pr.optElem().avg << endl;
        }
        else
        {
            cout <<"There is no student in the file! \n";
        }
    }catch (SeqInFileEnumerator<Mark>::Exceptions ex)
    {
        cout <<"File not found !" <<endl;
        return 1;
    }
    return 0;
}

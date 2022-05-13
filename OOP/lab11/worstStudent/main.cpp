#include <iostream>
#include "library/stringstreamenumerator.hpp"
#include "library/linsearch.hpp"
#include "library/seqinfileenumerator.hpp"
#include "library/enumerator.hpp"
#include "library/maxsearch.hpp"
#include "library/counting.hpp"
/*
we have grade of the students in different tasks for a subject  in one line of  the file.
Data of one student can be in more than one line of file.
Give the student who passed the least number of courses.
A student passes a course if he/she obtains at least 2 in all the tasks.
*/
using namespace std;

struct Mark{
    string taskName;
    int grade;

    friend istream& operator>>(istream &is, Mark &m)
    {
        is>>m.taskName>>m.grade;
        return is;
    }
};

class passedCourse : public LinSearch<Mark, true>
{
    bool cond(const Mark &e) const override {return e.grade >= 2;}
};

struct Course{
    string stdName;
    string crsName;
    bool passed;

    friend istream &operator>>(istream &is, Course &c);
};
istream &operator>>(istream &is, Course &c)
{
    string line;
    getline(is,line);
    stringstream ss(line);
    ss>>c.stdName>>c.crsName;
    passedCourse pr;
    StringStreamEnumerator<Mark> ssenor(ss);

    pr.addEnumerator(&ssenor);

    pr.run();

    c.passed = pr.found();
    return is;
};
class passedCount : public Counting<Course>
{
private:
    string _name;
public:
    passedCount(const string &name) : _name(name){}
public:
    bool cond(const Course& e) const { return e.passed; }
    bool whileCond(const Course& current) const override { return current.stdName== _name; }
    void first() override {}
};

struct Student {
    string name;
    int passedCourses;
};
class StudentEnor : public Enumerator<Student>
{
private:
    SeqInFileEnumerator<Course>*_f;
    Student _student;
    bool _end;

public:
    StudentEnor(const string &fname) {_f = new SeqInFileEnumerator<Course>(fname);}
    ~StudentEnor() {delete _f;}
    void first() override {_f->first(); next();}
    void next() override;
    bool end() const override {return _end;}
    Student current() const override {return _student;}
};

void StudentEnor::next()
{
    _end = _f->end();
    if(_end)
    {
        return ;
    }
    _student.name = _f->current().stdName;

    passedCount pr(_student.name);

    pr.addEnumerator(_f);

    pr.run();

    _student.passedCourses = pr.result();
}

class minPassed :public MaxSearch<Student, int, Less<int>>
{
   int func(const Student& e) const override {return e.passedCourses;}
};
int main()
{
    try{
        minPassed pr;
        StudentEnor enor("input.txt");

        pr.addEnumerator(&enor);

        pr.run();

        cout<< "Student who passed the least courses is " <<pr.optElem().name<< " with " <<pr.opt() <<" passed." <<endl;

    }catch(SeqInFileEnumerator<Course>::Exceptions ex)
    {
        cout <<"File not found !"<<endl;
        return 1;
    }
    return 0;
}

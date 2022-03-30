#include "InFile.h"

std::istream &operator>>(std::istream &is, flightTable &f)
{
    is >> f.date >> f.id >> f.cap >> f.people;
    return is;
}

InFile::InFile(const string &filename)
{
    _x.open(filename.c_str());
    if(_x.fail()) throw FILE_ERROR;

}

void InFile::read()
{
    _x >>_dx;
    if(_x.fail())
    {
        _sx=abnorm;
    }
    else
    {
        _sx=norm;
    }
}

void InFile::next()
{
    _end = (_sx == abnorm);
    if(!_end)
    {
        _cur.id = _dx.id;
        _cur.isbig = false;
        _cur.rateOfpeop = 0;


        _cur.isbig = (_dx.cap>=150);
        _cur.rateOfpeop = double(_dx.people)/_dx.cap;
        cout<<" id: "<<_dx.id <<" isbig: "<<_cur.isbig<<" rate of people: "<<_cur.rateOfpeop<<endl;
        read();

    }
}

#include "InFile.h"


std::istream &operator>>(std::istream &is, teachInfo &t)
{
    is >> t.term >> t.id >> t.hour;
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
        _cur.id=_dx.id;
        _cur.hour=_dx.hour;
        read();

    }
}


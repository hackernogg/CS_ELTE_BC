#include "inFile.h"

std::ostream &operator<<(std::ostream &os, const Occurrence &o)
{
    os << "Num: " << o.number << ", Occurence : " << o.occur;
    return os;
}

inFile::inFile(const std::string &filename)
{
    _x.open(filename.c_str());
    if(_x.fail())
    {
        throw FILE_ERROR;
    }
}


void inFile::read()
{
    _x >> _dx;
    if(_x.fail())
    {
        _sx = abnorm;
    }
    else
    {
        _sx = norm;
    }
    /// _sx = (_x >>_dx) ? norm : abnorm;
}

void inFile::next()
{
    _end = (_sx == abnorm);

    if(!_end)
    {
        _cur.number = _dx;
        _cur.occur = 0;

        while (_sx == norm && _dx == _cur.number)
        {
            _cur.occur++;
            read();
        }
    }
}

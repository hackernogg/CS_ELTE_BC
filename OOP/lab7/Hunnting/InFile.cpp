#include "InFile.h"

std::istream &operator>>(std::istream &is, Hunt &h)
{
    is >> h.hunter >> h.prey >> h.weight;
    return is;
}

InFile::InFile(const std::string &filename)
{
    _x.open(filename.c_str());
    if(_x.fail()) throw FILE_ERROR;

}

void InFile::read()
{
    _x >> _dx;
    if(_x.fail())
    {
        _sx=abnorm;
    }
    else
    {
        _sx=norm;
    }
    //_sx = (_x >> _dx) ? norm : abnorm;
}

void InFile::next()
{
    _end = (_sx == abnorm);
    if(!_end)
    {
        _cur.name = _dx.hunter;
        _cur.shotRabbit = false;
        _cur.cntHunnts = 0;

        for(;_sx == norm && _cur.name == _dx.hunter; read())
        {
            _cur.shotRabbit = _cur.shotRabbit || (_dx.prey == "rabbit");
            _cur.cntHunnts++;
        }
    }
}

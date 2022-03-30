#ifndef INFILE_H
#define INFILE_H
#include <iostream>
#include <fstream>

using namespace std;

enum Status {norm,abnorm};

struct flightTable
{
    string date;
    string id;
    int cap;
    int people;

    friend std::istream &operator>>(std::istream &is, flightTable &f);
};

struct flight
{
    string id;
    bool isbig;
    double rateOfpeop;


};

class InFile
{
    public:
        enum Errors { FILE_ERROR };
        InFile(const string &filename);
        ~InFile() {_x.close();}

        void first() {read(); next();};
        void next();

        flight current() {return _cur;};
        bool end() {return _end;};


    private:
        ///st, e, f : read
        std::ifstream _x;
        Status _sx;
        flightTable _dx;

        flight _cur;
        bool _end;

        void read();

};

#endif // INFILE_H

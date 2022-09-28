#ifndef INFILE_H
#define INFILE_H
#include <iostream>
#include <fstream>
using namespace std;

enum Status {norm, abnorm};

struct teachInfo{
    string term;
    string id;
    int hour;

    friend std::istream &operator>>(std::istream &is, teachInfo &t);
};
struct teacher{
    string id;
    int hour;
};
class InFile
{
    public:
        enum Errors { FILE_ERROR };
        InFile(const std::string &filename);
        ~InFile() { _x.close();};

        void first() {read(); next();}
        void next();

        teacher current() {return _cur;}
        bool end() { return _end; }



    private:
        ///st, e, f : read
        std::ifstream _x;
        Status _sx;
        teachInfo _dx;

        teacher _cur;
        bool _end;

        void read();
};

#endif // INFILE_H

#ifndef INFILE_H
#define INFILE_H
#include <iostream>
#include <fstream>
using namespace std;

enum Status {norm, abnorm};

struct voteInfo
{
    string name;
    int votes;

    friend std::istream &operator>>(std::istream &is, voteInfo &v);
};

struct people
{
    string name;
    int votes;
};

class InFile
{
    public:
        enum Errors { FILE_ERROR };
        InFile(const std::string &filename);
        ~InFile() { _x.close();};

        void first() {read(); next();}
        void next();

        people current() {return _cur;}
        bool end() { return _end; }

    private:
        ///st, e, f : read
        std::ifstream _x;
        Status _sx;
        voteInfo _dx;

        people _cur;
        bool _end;

        void read();
};

#endif // INFILE_H

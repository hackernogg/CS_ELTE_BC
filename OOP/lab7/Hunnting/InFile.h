#ifndef INFILE_H
#define INFILE_H
#include <iostream>
#include <fstream>
using namespace std;

enum Status {norm, abnorm};
struct Hunt {
    string hunter;
    string prey;
    int weight;

    friend std::istream &operator>>(std::istream &is, Hunt &h);
};

struct Hunter{
    string name;
    bool shotRabbit;
    int cntHunnts;
};

class InFile
{
    public:
        enum Errors { FILE_ERROR };
        InFile(const std::string &filename);
        ~InFile() { _x.close();};

        void first() {read(); next();}
        void next();

        Hunter current() { return _cur; }
        bool end() { return _end; }/// return _sx == abnorm;


    private:
        ///st, e, f : read
        std::ifstream _x;
        Status _sx;
        Hunt _dx;

        Hunter _cur;
        bool _end;

        void read();
};

#endif // INFILE_H

#ifndef INFILE_H
#define INFILE_H

#include <iostream>
#include <fstream>
struct Occurrence {
    int number;
    int occur;

    friend std::ostream &operator<<(std::ostream &os, const Occurrence &o);
};

enum Status {norm, abnorm};

class inFile
{
    public:

        enum Errors { FILE_ERROR };

        inFile(const std::string &filename);
        ~inFile() { _x.close(); }

        void first() {read(); next(); }
        void next();
        Occurrence current() { return _cur; }

        bool end() { return _end;}//_xs==abnorm;

    private:
        /// read : st, e, t
        std::ifstream _x;
        int _dx;
        Status _sx;

        Occurrence _cur;
        bool _end;

        void read();
};

#endif // INFILE_H

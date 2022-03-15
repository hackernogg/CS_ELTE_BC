#ifndef MATRIX_H
#define MATRIX_H
#include <iostream>
#include <vector>
#include <fstream>
#include <math.h>

using namespace std;

class matrix
{
    public:
        ///Exceptions
        class InvalidIndexException : public exception {};
        class OutOfTriangleException : public exception {};
        class DimensionMismatchException : public exception {};
        class InvalidVectorException : public exception {};

        ///constructors
        matrix();
        matrix(int size);
        matrix(const string &fileName);

        ///Getters
        int getSize() const { return _size ;}
        int getElement(int i, int j) const;

        ///Setters
        void setVec(const vector<int> &vec);
        void setElement(int i, int j, int e);

        ///Static methods
        static matrix add(const matrix &a, const matrix &b);
        static matrix multiply(const matrix &a, const matrix &b);

        ///Operator overloading
        friend std::ostream &operator<<(ostream &os, const matrix &m);

    private:
        ///attributes
        int _size = 8;
        //underline to mark it as private
        vector<int> _vec;

        ///Private methods
        int ind(int i, int j) const;
        double calcSizeFromLength(unsigned int size);
        //unsigned == positive number
        bool inLowerTrng(int i, int j) const;

};

#endif // MATRIX_H

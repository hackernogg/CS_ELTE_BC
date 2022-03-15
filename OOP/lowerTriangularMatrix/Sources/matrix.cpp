#include "matrix.h"

///Constructors

matrix::matrix() /// basic 3x3 matrix
{
    _size = 3;
    _vec = {1,2,3,4,5,6};
}

matrix::matrix(int size)///zero matrix with given size
{
    _size = size;
    _vec.resize(size*(size + 1)/2, 0);
}
matrix::matrix(const std::string &fileName) ///matrix read from a file
{
    fstream f(fileName);
    if (f.fail())
    {
        _size = 0;
        _vec.clear();
    }
    else
    {
        int e;
        while (f>>e)
        {
            _vec.push_back(e);
        }
        double n = calcSizeFromLength(_vec.size());
        if( n == floor(n))//4.65 ->4 ,4.03 ->4
        {
            _size = n;
        }
        else
        {
            _size = 0;
            _vec.clear();
        }
    }
}

///Private methods
int matrix::ind(int i,int j) const ///vector index from matrix indices, indexing from zero
{
    return (i*(i-1)/2 +j)-1;
}

double matrix::calcSizeFromLength(unsigned int size) ///calculate the matrix size based on the vector size
{
    return (sqrt(size*8 +1)-1)/2;
}

bool matrix::inLowerTrng(int i, int j) const /// are they indices of the lower triangular part
{
    return (1<=j && j<=i && i<= _size);
}

///Getters
int matrix::getElement(int i, int j) const ///get matrix element by indices
{
    if(inLowerTrng(i,j))
    {
        return _vec[ind(i,j)];
    }
    else if(1<=j && j<=_size && 1<=i && i<= _size)
    {
        return 0;
    }
    else
    {
        throw InvalidIndexException();
    }
}

///Setter
void matrix::setVec(const std::vector<int> &vec) ///Modifying the whole matrix
{
    double n = calcSizeFromLength(vec.size());
    if (n==floor(n))
    {
        _size = n;
        _vec = vec;
    }
    else
    {
        throw InvalidVectorException();
    }
}

void matrix::setElement(int i, int j, int e)
{
    if(inLowerTrng(i,j))
    {
        _vec[ind(i,j)] = e;
    }
    else
    {
        throw OutOfTriangleException();
    }
}

///Static methods

matrix matrix::add(const matrix& a, const matrix& b)
{
    if(a.getSize()== b.getSize())
    {
        matrix sum(a.getSize());
        for (int i = 0; i < a._vec.size(); i++)
        {
            sum._vec[i] = a._vec[i] + b._vec[i];
        }
        return sum;
    }
    else
    {
        throw DimensionMismatchException();
    }
}

matrix matrix::multiply(const matrix &a, const matrix &b)
{
    if(a.getSize()==b.getSize())
    {
        matrix mul(a.getSize());
        for (int i = 1; i<=a._size;i++)
        {
            for(int j = 1; j <= a._size ;j++)
            {
                if(a.inLowerTrng(i,j))
                {
                    for(int k = j; k<= i; k++)
                    {
                        mul.setElement(i,j,mul.getElement(i,j)+a.getElement(i,k)*b.getElement(k,j));
                    }
                }

            }

        }
        return mul;
    }
    else
    {
        throw DimensionMismatchException();
    }
}

std::ostream &operator<<(ostream &os, const matrix &m)
{
    os<<m._size<<" x "<<m._size<<endl;
    for(int i = 1; i <= m._size;i++)
    {
        for(int j = 1; j<=m._size;j++)
        {
            os<<m.getElement(i,j) << " ";
        }
        os<<endl;
    }
    return os;
}


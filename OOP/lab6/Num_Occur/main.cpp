#include <iostream>
#include "inFile.h"

using namespace std;

int main()
{
    bool fileError = true;

    do
    {
        try{
            string filename;
            cout << "Filename: ";
            cin >>filename;

            inFile t(filename);

            for (t.first(); !t.end(); t.next())
            {
                cout << t.current() <<endl;
            }
            fileError = false;

        }catch (inFile::Errors er)
        {
            cerr << "File opening unsuccessful!";
        }
    }while(fileError);
    return 0;
}

#include <iostream>
#include "InFile.h"
/*
Lufthansa Group has published statistics about its flights in a sequential input file: date, plane ID, passenger capacity (PC), number of passengers (NoP).

 After the first half-empty flight (NoP/PC<=0.5) how many flights were there, where the plane was big (PC>=150)?
 You have to define a method for reading from the file and you have to create an algorithm which is based on the general algorithm of the algorithmic patterns.
*/
using namespace std;

int main()
{
    try
    {
        string filename;
        filename = "input.txt";

        InFile t(filename);
        int cnt = 0;
        bool firstHalf;
        firstHalf = false;

        for(t.first(); !t.end(); t.next())
        {
            if(firstHalf == true && t.current().isbig == true){
                cnt++;
            }

            if(t.current().rateOfpeop<=0.5&&firstHalf == false){
                firstHalf = true;

            }

        }
        cout << "After the first half-empty flight (NoP/PC<=0.5) how many flights were there, where the plane was big (PC>=150)?" << cnt <<endl;
    }catch (InFile::Errors err)
    {
        cerr << "Invlaid file!!!\n";
    }
    return 0;
}

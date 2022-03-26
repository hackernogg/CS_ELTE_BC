#include <iostream>
#include "InFile.h"
/*
In a sequential input file, hunt trophies are stored:hunter, name , species, weight.
How many hunters have shot rabbit(In any of their hunts)?

*/
/// On average, how many preys have the hunters shot? In case of empty file, the average is zero!
using namespace std;


int main()
{
    try{
        string filename;
        filename = "input.txt";

        InFile t(filename);
        int cntwithRabbit = 0;
        int cnt = 0;
        int sum = 0;

        for(t.first(); !t.end(); t.next())
        {
            sum += t.current().cntHunnts;
            cnt++;
            if(t.current().shotRabbit)
            {
                cntwithRabbit++;
            }
        }
        double avg = 0;
        if(cnt > 0 ){
                avg = double(sum)/cnt;
        }
        cout << "Hunters with rabbit shot are: " << cntwithRabbit <<endl;
        cout << "how many preys have the hunters shot? " << avg <<endl;
    }catch (InFile::Errors err)
    {
        cerr << "Invlaid file!\n";
    }
    return 0;
}



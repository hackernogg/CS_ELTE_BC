#include <iostream>
#include <fstream>
using namespace std;
enum Status {norm, abnorm};

void read(Status &st, double &e, fstream &f);

string readfilename();

double division(double sum, int cnt);

double avgBefore (fstream &f);

double avgAfter(fstream &f);

pair<double, double> avgBeforeNafter(fstream &f);

void menuPrint();

void execute(int n, fstream &f);

int main()
{

    int menuItem;
    do{
        menuPrint();
        cin >> menuItem;
        if(menuItem > 0 && menuItem <4)
        {
                string filename = readfilename();
                fstream f(filename);
                if(f.fail())
                {
                    cerr<<"File reading unsuccessful! \n";
                }else
                {
                    execute(menuItem,f);
                }
        }
    }while(menuItem != 0);


    //cout << avgBefore(f) << endl;
    //cout << avgAfter(f) << endl;

    return 0;
}

void menuPrint()
{
    cout << "0: Exit\n";
    cout << "1: Average Before \n";
    cout << "2: Average After \n";
    cout << "3: Average Before and After \n";
    cout << "Choose Menu Item: ";
}
void execute(int n, fstream &f)
{
    switch(n)
    {
        case 1:
            cout << avgBefore(f)<<endl;
            break;
        case 2:
            cout << avgAfter(f)<<endl;
            break;
        case 3:
            pair<double,double> result = avgBeforeNafter(f);
            cout << result.first<< " " <<result.second << endl;
            break;
    }
}

void read(Status &st, double &e, fstream &f)
{
    f >> e;
    if(f.fail())
    {
        st = abnorm;
    }
    else
    {
        st = norm;
    }
    //st = (f>>e) ? norm : abnorm;
}

string readfilename()
{
    string filename;
    cout << "Filename :";
    cin >> filename;
    return filename;
}

double division(double sum, int cnt)
{
    if(cnt == 0)
    {
        return 0;
    }
    else
    {
        return sum/cnt;
    }
}

double avgBefore(fstream &f)
{
    Status st;
    double e;
    double sum = 0;
    int cnt = 0;

    read(st, e ,f);
    /// 4 5 6 7
    /// 5 6 7
    /// 6 7

    while (e >= 0 && st == norm)
    {
        sum += e;
        ++cnt;/// cnt++ both ok

        read(st, e, f);
    }



    return division(sum, cnt);
}

double avgAfter(fstream &f)
{
    Status st;
    double e;

    read(st, e, f);
    while (e >= 0 && st == norm)
    {
        read(st, e, f);
    }

    double sum = 0;
    int cnt = 0;
    read(st, e, f);

    while(st==norm)
    {
        sum += e;
        cnt++;
        read(st, e, f);
    }

    return division(sum,cnt);
}

pair<double, double> avgBeforeNafter(fstream &f)
{
    Status st;
    double e;
    double sumBefore = 0;
    int cntBefore = 0;

    read(st, e, f);
    while(e >= 0 && st == norm)
    {
        sumBefore += e;
        cntBefore++;
        read(st, e, f);
    }
    double avgBef = division(sumBefore, cntBefore);
    double sumAfter =0;
    int cntAfter = 0;

    while(st == norm)
    {
        sumAfter += e;
        cntAfter++;
        read(st, e, f);
    }

    double avgAft = division(sumAfter, cntAfter);

    return pair<double, double>(avgBef, avgAft);

}

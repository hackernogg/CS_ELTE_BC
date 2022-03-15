#include <iostream>
#include <fstream>
#include <vector>
using namespace std;

bool fileRead(vector<int> &vec, const string &filename);
bool condMaxSearch(const vector<int> &vec,int &max, int &ind);
bool condMaxSearchFromFile(const string &filename, int &max);

int main()
{
    vector<int> vec;
    int max , ind;
    string filename = "input.txt";
    if(fileRead(vec, filename)){
        if(condMaxSearch(vec, max , ind)){
            cout << "Highest valley is " << max <<endl;
        }else {
            cout << "there is no valley "<< endl;
        }
        if(condMaxSearchFromFile(filename, max)){
            cout << " Highest valley from file is " << max <<endl;
        }else {
            cout << "there is no valley from file"<< endl;
        }
    }
    return 0;
}

bool fileRead(vector<int> &vec, const string &filename) {
    fstream f(filename);
    if (f.fail()){
        return false;
    }
    int e;
    while (f >> e){
        vec.push_back(e);
    }
    f.close();
    return true;
}


bool condMaxSearch(const vector<int> &vec,int &max, int &ind) {
    bool l= false;
    for(int i=1; i < vec.size() -1; i++){
        if (l && vec[i] <= vec[i-1] && vec[i] <= vec[i+1]){
            if(max <vec[i]){
                max = vec[i];
                ind = i;
            }
        }else if (!l && vec[i] <= vec[i-1] && vec[i] <= vec[i+1]){
            l = true;
            max = vec[i];
            ind = i;
        }
    }
    return l;


}

bool condMaxSearchFromFile(const string &filename, int &max){
    fstream f(filename);
    bool l = false;
    int before, current ,after;
    f >> before;
    f >> current;
    f >> after;
    while (!f.fail()){
        if (l && current <= before &&current <= after){
            if(max < current){
                max = current;
            }
        }else if (!l && current <= before &&current <= after){
            l = true;
            max = current;
        }
        before = current;
        current = after;
        f >> after;
    }
    f.close();
    return l;
}

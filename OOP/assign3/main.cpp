//Author:        Tibor Gregorics
//Date:          2017.08.08.
//Title:         Competition of creatures

#include <iostream>
#include <cstdlib>
#include <fstream>
#include <vector>
#include "creature.h"
#include "ground.h"

using namespace std;

//Task:          Filling the vector of creatures and the racetrack from a file of a given name
//Input:         string str	- name of the text file
//Output:        vector<Creature*> &creatures  - vector of pointers of the creatures
//               vector<Ground*> &track - vector of the grounds of the racetrack
//Activity:      creating the creatures and their pointers
//               filling the vector of creatures
//               filling the vector of the racetrack
void create(const string &str, vector<Creature*> &creatures, vector<Ground*> &track)
{
    ifstream f(str);
    if(f.fail()) { cout << "Wrong file name!\n"; exit(1);}

    // population of the creatures
    int n; f >> n;
    creatures.resize(n);
    for( int i=0; i<n; ++i ){
        char ch; string name; int p;
        f >> ch >> name >> p;
        switch(ch){
            case 'G' : creatures[i] = new Greenfinch(name, p); break;
            case 'D' : creatures[i] = new DuneBeetle(name, p); break;
            case 'S' : creatures[i] = new Squelchy(name, p);   break;
        }
    }

    // population of the racetrack
    int m; f >> m;
    track.resize(m);
    for( int j=0; j<m; ++j ) {
        int k; f >> k;
        switch(k){
            case 0 : track[j] = Sand::instance();  break;
            case 1 : track[j] = Grass::instance(); break;
            case 2 : track[j] = Marsh::instance(); break;
        }
    }
}

//Task:       The competition
//Input:      vector<Creature*> &creatures  - vector of pointers of the creatures
//            vector<Ground*> &track - vector of the grounds of the racetrack
//Output:     vector<Creature*> &creatures  - vector of pointers of the creatures
//            vector<Ground*> &track - vector of the grounds of the racetrack
//            vector<string> alive - names of the alive creatures
//Activity:   every creature crosses the track one after the other (meanwhile the track may change),
//            as long as the creature is alive.
//            collects the names of the alive creatures
void race(vector<Creature*> &creatures, vector<Ground*> &track, vector<string>& alive)
{
    alive.clear();
    try{
        for( unsigned int i=0; i < creatures.size(); ++i ){
            for( unsigned int j=0; creatures[i]->alive() && j < track.size(); ++j ){
                creatures[i]->transmute(track[j]);
            }
            if ( creatures[i]->alive() ) alive.push_back(creatures[i]->name());
        }
    }catch(exception e){
        cout << e.what() << endl;
    }
}

//Task:       Destruction of the creatures
//Input:      vector<Creature*> &creatures  - vector of pointers of the creatures
//Activity:   destroys every dinamically allocated creature
void destroy(vector<Creature*> &creatures)
{
    for(int i=0; i<(int)creatures.size(); ++i) delete creatures[i];
}

//Task:       Destruction of the grounds
//Input:      vector<Ground*> &track - vector of the grounds of the racetrack
//Activity:   destroys every dinamically allocated ground
void destroyGround()
{
    Sand::destroy();
    Grass::destroy();
    Marsh::destroy();
}

// To change between the manual and the unit test mode
#define NORMAL_MODE
#ifdef NORMAL_MOD


//Task:       Competition for different creatures and assortment of the name of those who survived it
//Input:      text file
//Output:     names of creatures written to the console
//Activity:   Creating the competitors and the racetrack based on the file
//            Simulation of the competition and writing the result
int main()
{
    vector<Creature*> creatures;
    vector<Ground*> track;
    create("inp.txt", creatures, track );

    // Competition
    vector<string> alive;
    race(creatures, track, alive);
    for(unsigned int i=0; i<alive.size(); ++i) cout << alive[i] << endl;

    // Destruction of the objects
    destroy(creatures);
    destroyGround();
    return 0;
}

#else
#define CATCH_CONFIG_MAIN
#include "catch.hpp"

TEST_CASE("1", "inp1*.txt")
{
    vector<Creature*> creatures;
    vector<Ground*> track;
    vector<string> alive;

    create("inp11.txt", creatures, track);
    race(creatures, track, alive);
    CHECK(alive.size() == 0);
    destroy(creatures);

    create("inp12.txt", creatures, track );
    race(creatures, track, alive);
    CHECK(alive.size() == 1);
    destroy(creatures);

    create("inp13.txt", creatures, track );
    race(creatures, track, alive);
    CHECK(alive.size() == 2);
    destroy(creatures);

    create("inp21.txt", creatures, track );
    race(creatures, track, alive);
    CHECK(alive[0] == "plash");
    CHECK(alive[1] == "bug");
    destroy(creatures);

    create("inp22.txt", creatures, track );
    race(creatures, track, alive);
    CHECK(alive.size() == 0);
    destroy(creatures);
/*
    destroyGround();
}

TEST_CASE("2", "inp2*.txt")
{
    vector<Creature*> creatures;
    vector<Ground*> track;
    vector<string> alive;
*/
    creatures.clear();
    track.clear();
    create("inp21.txt", creatures, track );
    race(creatures, track, alive);

    CHECK(alive[0] == "plash");
    CHECK(alive[1] == "bug");
    destroy(creatures);

    create("inp22.txt", creatures, track );
    race(creatures, track, alive);
    CHECK(alive.size() == 0);
    destroy(creatures);
/*
    destroyGround();
}

TEST_CASE("3", "") {

    vector<Creature*> creatures;
    vector<Ground*> track;
    vector<string> alive;
*/
    creatures.clear();
    track.clear();
    creatures.push_back(new Greenfinch("greenish", 1));
    race(creatures, track, alive);

    CHECK(creatures[0]->alive() == true);

    destroy(creatures);


    creatures.clear();
    track.clear();
    creatures.push_back(new Greenfinch("greenish", 5));
    track.push_back(Sand::instance()); track.push_back(Grass::instance()); track.push_back(Marsh::instance());
    race(creatures, track, alive);

    CHECK(creatures[0]->alive() == true);
    CHECK(track[0] == Sand::instance());
    CHECK(track[1] == Grass::instance());
    CHECK(track[2] == Grass::instance());

    destroy(creatures);


    creatures.clear();
    track.clear();
    creatures.push_back(new DuneBeetle("bug", 5));
    track.push_back(Sand::instance()); track.push_back(Grass::instance()); track.push_back(Marsh::instance());
    race(creatures, track, alive);

    CHECK(creatures[0]->alive() == true);
    CHECK(track[0] == Sand::instance());
    CHECK(track[1] == Sand::instance());
    CHECK(track[2] == Grass::instance());

    destroy(creatures);


    creatures.clear();
    track.clear();
    creatures.push_back(new Squelchy("plash", 10));
    track.push_back(Sand::instance()); track.push_back(Grass::instance()); track.push_back(Marsh::instance());
    race(creatures, track, alive);

    CHECK(creatures[0]->alive() == true);
    CHECK(track[0] == Sand::instance());
    CHECK(track[1] == Marsh::instance());
    CHECK(track[2] == Marsh::instance());

    destroy(creatures);


    creatures.clear();
    track.clear();
    creatures.push_back(new Squelchy("plash", 5));
    track.push_back(Sand::instance()); track.push_back(Grass::instance()); track.push_back(Marsh::instance());
    race(creatures, track, alive);

    CHECK(creatures[0]->alive() == false);
    CHECK(track[0] == Sand::instance());
    CHECK(track[1] == Grass::instance());
    CHECK(track[2] == Marsh::instance());

    destroy(creatures);
/*
    destroyGround();
}

TEST_CASE("4", "") {

    vector<Creature*> creatures;
    vector<Ground*> track;
    vector<string> alive;
*/
    creatures.clear();
    track.clear();
    creatures.push_back(new DuneBeetle("bug", 1));
    track.push_back(Marsh::instance()); track.push_back(Grass::instance());
    race(creatures, track, alive);

    CHECK(creatures[0]->alive() == false);
    CHECK(track[0] == Grass::instance());
    CHECK(track[1] == Grass::instance());

    destroy(creatures);


    creatures.clear();
    track.clear();
    creatures.push_back(new DuneBeetle("bug", 3));
    track.push_back(Grass::instance()); track.push_back(Marsh::instance());
    race(creatures, track, alive);

    CHECK(creatures[0]->alive() == false);
    CHECK(track[0] == Sand::instance());
    CHECK(track[1] == Grass::instance());

    destroy(creatures);
    destroyGround();
}

#endif // NORMAL_MODE

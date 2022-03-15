#include <iostream>
#include <vector>
#include "prqueue.h"
#include "menu.h"

using namespace std;

/// Change between manual mode and unit test mode
#define NORMAL_MODE
#ifdef NORMAL_MODE

int main()
{
    cout << "Priority queue" << endl;

    Menu menu;
    menu.Run();

    return 0;
}

#else
#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#include "prqueue.h"

///Test cases mentioned on practice

TEST_CASE("isEmpty()","[PrQueue]")
{
    PrQueue Q1;
    CHECK( Q1.isEmpty() == TRUE );

    Item e(1,"a");
    Q1.add(e);
    CHECK( Q1.isEmpty() == FALSE );

    e=Q1.remMax();
    CHECK( Q1.isEmpty() == TRUE );
}

TEST_CASE("add","[PrQueue]")
{
    PrQueue Q;
    Item e1(1,"a"); Item e2(2,"b"); Item e3(3,"c"); Item e4(4,"d"); Item e5(5,"e");

    {
        Q.add(e1);
        CHECK( 1 == Q.getLength());
        vector<Item> v= Q.getItems();
        CHECK( v[0] == e1 );
    }

    {
        Q.add(e2);Q.add(e3);Q.add(e4);Q.add(e5);
        CHECK( 5 == Q.getLength());
        vector<Item> v= Q.getItems();
        CHECK( e1 == v[0]); CHECK( e2 == v[1]); CHECK( e3 == v[2]); CHECK( e4 == v[3]); CHECK( e5 == v[4]);
    }
}

TEST_CASE("maxindex max remMax","[max] [PrQueue]")
{
    ///maxindex and remMax
    SECTION("Exception Throws")
    {
        PrQueue Q;
        CHECK_THROWS(Q.max());
        CHECK_THROWS(Q.remMax());

    }

    ///Items for testing
    Item e;
    Item e1(1,"a"); Item e2(2,"b"); Item e3(3,"c"); Item e5(5,"a");
    SECTION("one item")
    {
        PrQueue Q;
        Q.add(e1);
        CHECK(0 == Q.getMaxindex());
        e=Q.max();
        CHECK( e == e1 );
        e=Q.remMax();
        CHECK( 0 == Q.getLength());
        CHECK( e == e1 );
    }

    SECTION("more items, first is maximal")
    {
        PrQueue Q;
        Q.add(e5); Q.add(e2); Q.add(e3);
        CHECK(0 == Q.getMaxindex());
        e=Q.max();
        CHECK( e == e5 );
        e=Q.remMax();
        CHECK( 2 == Q.getLength());
        CHECK( e == e5 );
        vector<Item> v=Q.getItems();
        CHECK(v[0]==e3); CHECK(v[1]==e2);
    }

    SECTION("more items, last is maximal")
    {
        PrQueue Q;
        Q.add(e1); Q.add(e2); Q.add(e3);
        CHECK(2 == Q.getMaxindex());
        e=Q.max();
        CHECK( e == e3 );
        e=Q.remMax();
        CHECK( 2 == Q.getLength());
        CHECK( e == e3 );
        vector<Item> v=Q.getItems();
        CHECK(v[0]==e1); CHECK(v[1]==e2);
    }

    SECTION("more items, middle is maximal")
    {
        PrQueue Q;
        Q.add(e1); Q.add(e3); Q.add(e2);
        CHECK(1 == Q.getMaxindex());
        e=Q.max();
        CHECK( e == e3 );
        e=Q.remMax();
        CHECK( 2 == Q.getLength());
        CHECK( e == e3 );
        vector<Item> v=Q.getItems();
        CHECK(v[0]==e1); CHECK(v[1]==e2);
    }

    Item e5c(5,"c");
    SECTION("more items, first and last are maximal")
    {
        PrQueue Q;
        Q.add(e5); Q.add(e2); Q.add(e5c);
        CHECK(0 == Q.getMaxindex());
        e=Q.max();
        CHECK( e == e5 );
        e=Q.remMax();
        CHECK( 2 == Q.getLength());
        CHECK( e == e5 );
        vector<Item> v=Q.getItems();
        CHECK(v[0]==e5c); CHECK(v[1]==e2);
    }

    Item e3b(3,"b");
    SECTION("more items, middle and last are maximal")
    {
        PrQueue Q;
        Q.add(e1); Q.add(e3b); Q.add(e3);
        CHECK(1 == Q.getMaxindex());
        e=Q.max();
        CHECK( e == e3b );
        e=Q.remMax();
        CHECK( 2 == Q.getLength());
        CHECK( e == e3b );
        vector<Item> v=Q.getItems();
        CHECK(v[0]==e1); CHECK(v[1]==e3);
    }

    Item e3a(3,"a");
    SECTION("more items, all are maximal")
    {
        PrQueue Q;
        Q.add(e3a); Q.add(e3b); Q.add(e3);
        CHECK(0 == Q.getMaxindex());
        e=Q.max();
        CHECK( e == e3a );
        e=Q.remMax();
        CHECK( 2 == Q.getLength());
        CHECK( e == e3a );
        vector<Item> v=Q.getItems();
        CHECK(v[0]==e3); CHECK(v[1]==e3b);
    }

    SECTION("remMaxes then add")
    {
        PrQueue Q;
        Q.add(e2); Q.add(e3); Q.add(e1);
        e=Q.remMax();
        CHECK( 2 == Q.getLength());
        CHECK( e == e3 );
        vector<Item> v=Q.getItems();
        CHECK(v[0]==e2); CHECK(v[1]==e1);
        e=Q.remMax();
        CHECK( 1 == Q.getLength());
        CHECK( e == e2 );
        v.clear();
        v=Q.getItems();
        CHECK(v[0]==e1);
        e=Q.remMax();
        CHECK( 0 == Q.getLength());
        CHECK( e == e1 );
        Q.add(e3);Q.add(e2);Q.add(e1);
        v.clear();
        for(int i=1; i<=3; ++i) v.push_back(Q.remMax());
        CHECK(v[0]==e3);CHECK(v[1]==e2);CHECK(v[2]==e1);
        CHECK(Q.isEmpty()==TRUE);
    }


}

#endif


#include <iostream>
#include <vector>
#include "bagqueue.h"
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
#include "bagqueue.h"
TEST_CASE("isEmpty()","[BagQueue]")
{
    BagQueue Q1;
    CHECK( Q1.isEmpty() == TRUE );

    Bag e(1,1);
    Q1.add(e);
    CHECK( Q1.isEmpty() == FALSE );

}

TEST_CASE("add","[BagQueue]")
{
    BagQueue Q;
    Bag e1(1,1); Bag e2(2,2); Bag e3(3,3); Bag e4(4,4); Bag e5(5,5);

    {
        Q.add(e1);
        CHECK( 1 == Q.getLength());
        vector<Bag> v= Q.getItems();
        CHECK( v[0] == e1 );
    }

    {
        Q.add(e2);Q.add(e3);Q.add(e4);Q.add(e5);
        CHECK( 5 == Q.getLength());
        vector<Bag> v= Q.getItems();
        CHECK( e1 == v[0]); CHECK( e2 == v[1]); CHECK( e3 == v[2]); CHECK( e4 == v[3]); CHECK( e5 == v[4]);
    }
}
TEST_CASE("Remove","[BagQueue]")
{
    BagQueue Q;
    Bag e1(1,1); Bag e2(2,2); Bag e3(3,3); Bag e4(4,4); Bag e5(5,5);

    {
        Q.add(e1);
        Q.rem();
        CHECK( 0 == Q.getLength());
        Q.add(e1);
        Q.add(e2);
        Q.rem();
        CHECK( 1 == Q.getLength());

    }


}
TEST_CASE("Find frequency","[BagQueue]")
{
    BagQueue Q;
    Bag e1(1,1); Bag e2(2,2); Bag e3(3,3); Bag e4(4,4); Bag e5(5,5);

    {
        Q.add(e1);
        Q.add(e2);
        Bag ans1= Q.GetFre(1);
        CHECK( e1 == ans1);
        Q.add(e3);
        Q.add(e4);
        Q.add(e5);
        Bag ans2= Q.GetFre(2);
        Bag ans3= Q.GetFre(3);
        Bag ans4= Q.GetFre(4);
        Bag ans5= Q.GetFre(5);
        CHECK( e2 == ans2);
        CHECK( e3 == ans3);
        CHECK( e4 == ans4);
        CHECK( e5 == ans5);

    }


}

TEST_CASE("Get Max","[BagQueue]")
{
    BagQueue Q;
    Bag e1(1,1); Bag e2(2,2); Bag e3(3,3); Bag e4(4,4); Bag e5(5,5);

    {
        Q.add(e1);
        Bag ans1= Q.MaxEle();
        CHECK( e1 == ans1);
        Q.add(e2);
        Bag ans2= Q.MaxEle();
        CHECK( e2 == ans2);
        Q.add(e3);
        Bag ans3= Q.MaxEle();
        CHECK( e3 == ans3);
        Q.add(e4);
        Bag ans4= Q.MaxEle();
        CHECK( e4 == ans4);
        Q.add(e5);
        Bag ans5= Q.MaxEle();
        CHECK( e5 == ans5);


    }


}



#endif

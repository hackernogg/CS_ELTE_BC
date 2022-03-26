#include <iostream>
#include <vector>
#include "map.h"
#include "menu.h"

using namespace std;

/// Change between manual mode and unit test mode
#define NORMAL_MODE
#ifdef NORMAL_MODE

int main()
{
    cout << "Map" << endl;

    Menu menu;
    menu.Run();

    return 0;
}

#else
#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#include "map.h"

///Test cases mentioned on practice

TEST_CASE("isEmpty, isIn","[Map]")
{
    Map M;
    CHECK( M.isEmpty() );

    Item e(1,"a");
    CHECK_FALSE( M.isIn(e.key) );
    M.insert(e);
    CHECK_FALSE( M.isEmpty() );
    CHECK( M.isIn(e.key) );

    M.erase(e.key);
    CHECK( M.isEmpty() );
    CHECK_FALSE( M.isIn(e.key) );
}

TEST_CASE("insert","[Map]")
{
    Map M;;
    Item e1(1,"a"); Item e2(2,"b"); Item e3(3,"c"); Item e4(4,"d"); Item e5(5,"e");

    M.insert(e2);
    CHECK( 1 == M.count());
    vector<Item> v= M.getItems();
    CHECK( v[0] == e2 );

    M.insert(e5);
    CHECK( 2 == M.count());
    v = M.getItems();
    CHECK( v[0] == e2 ); CHECK( v[1] == e5 );

    M.insert(e1);
    v= M.getItems();
    CHECK( v[0] == e1 ); CHECK( v[1] == e2 ); CHECK( v[2] == e5 );

    M.insert(e3);M.insert(e4);
    CHECK( 5 == M.count());
    v= M.getItems();
    CHECK( e1 == v[0]); CHECK( e2 == v[1]); CHECK( e3 == v[2]); CHECK( e4 == v[3]); CHECK( e5 == v[4]);
}

TEST_CASE("logsearch","[Map]")
{
    SECTION("empty map")
    {
        Map M;
        CHECK_FALSE(M.getLogSearch(3).first);///<false, ind>
    }

    ///Items for testing
    Item e1(1,"a"); Item e2(2,"b"); Item e3(3,"c"); Item e5(5,"a");
    SECTION("one item")
    {
        Map M;
        M.insert(e1);
        CHECK(M.getLogSearch(e1.key).first);
        CHECK(0 == M.getLogSearch(e1.key).second);
        M.erase(e1.key);
        CHECK( 0 == M.count());
    }

    SECTION("more items, first is searched")
    {
        Map M;
        M.insert(e5); M.insert(e2); M.insert(e3);
        CHECK(M.getLogSearch(e2.key).first);
        CHECK(0 == M.getLogSearch(e2.key).second);
        M.erase(e2.key);
        CHECK( 2 == M.count());
        vector<Item> v=M.getItems();
        CHECK(v[0]==e3); CHECK(v[1]==e5);
    }

    SECTION("more items, last is searched")
    {
        Map M;
        M.insert(e5); M.insert(e2); M.insert(e3);
        CHECK(M.getLogSearch(e5.key).first);
        CHECK(2 == M.getLogSearch(e5.key).second);
        M.erase(e5.key);
        CHECK( 2 == M.count());
        vector<Item> v=M.getItems();
        CHECK(v[0]==e2); CHECK(v[1]==e3);
    }

    SECTION("more items, middle is searched")
    {
        Map M;
        M.insert(e5); M.insert(e2); M.insert(e3);
        CHECK(M.getLogSearch(e3.key).first);
        CHECK(1 == M.getLogSearch(e3.key).second);
        M.erase(e3.key);
        CHECK( 2 == M.count());
        vector<Item> v=M.getItems();
        CHECK(v[0]==e2); CHECK(v[1]==e5);
    }

    SECTION("more items, searched does not exist")
    {
        Map M;
        M.insert(e5); M.insert(e2); M.insert(e3);
        CHECK_FALSE(M.getLogSearch(e1.key).first);
        CHECK(2 == M.getLogSearch(4).second);
    }
}
TEST_CASE("erase","[Map]")
{
    Item e1(1,"a"); Item e2(2,"b"); Item e3(3,"c"); Item e4(4,"d"); Item e5(5,"e");
    SECTION("erase first")
    {
        Map M;;

        M.insert(e2);
        M.insert(e3);
        M.insert(e1);

        M.erase(e1.key);
        CHECK( 2 == M.count());
        vector<Item> v=M.getItems();
        CHECK(v[0]==e2); CHECK(v[1]==e3);
    }
    SECTION("erase last")
    {
        Map M;;

        M.insert(e2);
        M.insert(e3);
        M.insert(e1);

        M.erase(e3.key);
        CHECK( 2 == M.count());
        vector<Item> v=M.getItems();
        CHECK(v[0]==e1); CHECK(v[1]==e2);
    }
    SECTION("erase middle")
    {
        Map M;;

        M.insert(e2);
        M.insert(e3);
        M.insert(e1);

        M.erase(e2.key);
        CHECK( 2 == M.count());
        vector<Item> v=M.getItems();
        CHECK(v[0]==e1); CHECK(v[1]==e3);
    }
}

TEST_CASE("exceptions","[Map]")
{
    SECTION("more items, middle is searched")
    {
        Item e1(1,"a"); Item e2(2,"b"); Item e3(3,"c"); Item e5(5,"a");
        Map M;
        CHECK_THROWS(M.erase(2));
        M.insert(e5); M.insert(e2); M.insert(e3);
        CHECK_THROWS(M.insert(e5));
        CHECK_THROWS(M.insert(e2));
        CHECK_THROWS(M.insert(e3));
        CHECK_THROWS(M.erase(4));
    }

    SECTION("Equality", "[MAP]")
    {
        Map m, n;
        Item e1(1, "a");
        Item e2(3, "a");
        m.insert(e1);
        n.insert(e2);
        CHECK(m[1] == n[3]);///"a" == "a"
    }

}

#endif

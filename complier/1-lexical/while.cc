#include <iostream>
#include <fstream>
#include <cstdlib>
#include "FlexLexer.h"

using namespace std;

void input_handler( ifstream& in, int argc, char* argv[] );

int main( int argc, char* argv[] )
{
    ifstream in;
    input_handler( in, argc, argv );
    yyFlexLexer lexer(&in);
    lexer.yylex();
    return 0;
}

void input_handler( ifstream& in, int argc, char* argv[] )
{
    if( argc < 2 )
    {
        cerr << "One command line argument expected." << endl;
        exit(1);
    }
    in.open( argv[1] );
    if( !in )
    {
        cerr << "Cannot open file: " << argv[1] << endl;
        exit(1);
    }
}

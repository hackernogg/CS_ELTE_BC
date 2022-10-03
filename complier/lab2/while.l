%option noyywrap c++ yylineno

%{
#include <iostream>
#include <stdlib.h>
%}

DIGIT  		[0-9]
WS          [ \t\n]
LETTER      [a-zA-Z]

%%


[0]|[1-9]{DIGIT}*         std::cout << "T_NOT_START_WITH_ZERO_NUM" << std::endl;
";"                       std::cout << "T_SEMICOLON" << std::endl;

. {
    std::cerr << "Line " << lineno() << ": Lexical error." << std::endl;
    exit(1);
}

%%

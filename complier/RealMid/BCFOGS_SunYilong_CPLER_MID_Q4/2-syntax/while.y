%baseclass-preinclude <iostream>

%lsp-needed

%token T_PROGRAM
%token T_BEGIN
%token T_END
%token T_INTEGER 
%token T_BOOLEAN
%token T_SKIP
%token T_IF
%token T_THEN
%token T_ELSE
%token T_ENDIF
%token T_WHILE
%token T_DO
%token T_DONE
%token T_READ
%token T_WRITE
%token T_SEMICOLON
%token T_ASSIGN
%token T_OPEN
%token T_CLOSE
%token T_NUM
%token T_TRUE
%token T_FALSE
%token T_ID
%token T_SET
%token T_CUROPEN
%token T_CURCLOSE
%token T_COMMA
%token T_QUESTION

%left T_OR T_AND
%left T_EQ
%left T_LESS T_GR
%left T_ADD T_SUB
%left T_MUL T_DIV T_MOD
%nonassoc T_NOT

%start program

%%

program:
    T_PROGRAM T_ID declarations T_BEGIN statements T_END
    {
        std::cout << "start -> T_PROGRAM T_ID declarations T_BEGIN statements T_END" << std::endl;
    }
;

declarations:
    // empty
    {
        std::cout << "declarations -> epsilon" << std::endl;
    }
|
    declaration declarations
    {
        std::cout << "declarations -> declaration declarations" << std::endl;
    }
;

declaration:
    type T_ID T_SEMICOLON
    {
        std::cout << "declaration -> type T_ID T_SEMICOLON" << std::endl;
    }
|
    type T_SET T_ID T_SEMICOLON
    {
        std::cout << "declaration -> type T_SET T_ID T_SEMICOLON" << std::endl;
    }
;
type:
    T_INTEGER
    {
        std::cout << "type -> T_INTEGER" << std::endl;
    }
|
    T_BOOLEAN 
    {
        std::cout << "type -> T_BOOLEAN" << std::endl;
    }
;

statements:
    statement
    {
        std::cout << "statements -> statement" << std::endl;
    }
|
    statement statements
    {
        std::cout << "statements -> statement statements" << std::endl;
    }
;

statement:
    T_SKIP T_SEMICOLON
    {
        std::cout << "statement -> T_SKIP T_SEMICOLON" << std::endl;
    }
|
    assignment
    {
        std::cout << "statement -> assignment" << std::endl;
    }
|
    read
    {
        std::cout << "statement -> read" << std::endl;
    }
|
    write
    {
        std::cout << "statement -> write" << std::endl;
    }
|
    branch
    {
        std::cout << "statement -> branch" << std::endl;
    }
|
    loop
    {
        std::cout << "statement -> loop" << std::endl;
    }
|
    T_ID T_ADD value T_SEMICOLON
    {
        std::cout << "statement -> T_ID T_ADD value T_SEMICOLON" << std::endl;
    }
;

value:
    T_NUM
    {
        std::cout << "value -> T_NUM" << std::endl;
    }
|
    T_TRUE
    {
        std::cout << "value -> T_TRUE" << std::endl;
    }
|
    T_FALSE
    {
        std::cout << "value -> T_FALSE" << std::endl;
    }
|
    T_ID
    {
        std::cout << "value -> T_ID" << std::endl;
    }
|
    value T_ADD value
    {
        std::cout << "value -> value T_ADD value" << std::endl;
    }
|
    value T_SUB value
    {
        std::cout << "value -> value T_SUB value" << std::endl;
    }
|
    value T_MUL value
    {
        std::cout << "value -> value T_MUL value" << std::endl;
    }
|
    value T_DIV value
    {
        std::cout << "value -> value T_DIV value" << std::endl;
    }
|
    value T_MOD value
    {
        std::cout << "value -> value T_MOD value" << std::endl;
    }
|
    value T_LESS value
    {
        std::cout << "value -> value T_LESS value" << std::endl;
    }
|
    value T_GR value
    {
        std::cout << "value -> value T_GR value" << std::endl;
    }
|
    value T_EQ value
    {
        std::cout << "value -> value T_EQ value" << std::endl;
    }
|
    value T_AND value
    {
        std::cout << "value -> value T_AND value" << std::endl;
    }
|
    value T_OR value
    {
        std::cout << "value -> value T_OR value" << std::endl;
    }
|
    T_NOT value
    {
        std::cout << "value-> T_NOT value" << std::endl;
    }
|
    T_OPEN value T_CLOSE
    {
        std::cout << "value -> T_OPEN expression T_CLOSE" << std::endl;
    }
;


assignment:
    T_ID T_ASSIGN expression T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_ASSIGN expression T_SEMICOLON" << std::endl;
    }
|
    T_ID T_ASSIGN instruction T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_ASSIGN instruction T_SEMICOLON" << std::endl;
    }
;

instruction:
    T_CUROPEN inset T_CURCLOSE
    {
        std::cout << "instruction -> T_CUROPEN inset T_CURCLOSE" << std::endl;
    }
;

inset:
    expression
    {
        std::cout << "inset -> expression" << std::endl;
    }
|
    expression T_COMMA inset
    {
        std::cout << "inset -> expression T_COMMA inset" << std::endl;
    }
;

read:
    T_READ T_OPEN T_ID T_CLOSE T_SEMICOLON
    {
        std::cout << "read -> T_READ T_OPEN T_ID T_CLOSE T_SEMICOLON" << std::endl;
    }
;

write:
    T_WRITE T_OPEN expression T_CLOSE T_SEMICOLON
    {
        std::cout << "write -> T_WRITE T_OPEN expression T_CLOSE T_SEMICOLON" << std::endl;
    }
;

branch:
    T_IF expression T_THEN statements T_ENDIF
    {
        std::cout << "branch -> T_IF expression T_THEN statements T_ENDIF" << std::endl;
    }
|
    T_IF expression T_THEN statements T_ELSE statements T_ENDIF
    {
        std::cout << "branch -> T_IF expression T_THEN statements T_ELSE statements T_ENDIF" << std::endl;
    }
;

loop:
    T_WHILE expression T_DO statements T_DONE
    {
        std::cout << "loop -> T_WHILE expression T_DO statements T_DONE" << std::endl;
    }
;

expression:
    T_NUM
    {
        std::cout << "expression -> T_NUM" << std::endl;
    }
|
    T_TRUE
    {
        std::cout << "expression -> T_TRUE" << std::endl;
    }
|
    T_FALSE
    {
        std::cout << "expression -> T_FALSE" << std::endl;
    }
|
    T_ID
    {
        std::cout << "expression -> T_ID" << std::endl;
    }
|
    expression T_ADD expression
    {
        std::cout << "expression -> expression T_ADD expression" << std::endl;
    }
|
    expression T_SUB expression
    {
        std::cout << "expression -> expression T_SUB expression" << std::endl;
    }
|
    expression T_MUL expression
    {
        std::cout << "expression -> expression T_MUL expression" << std::endl;
    }
|
    expression T_DIV expression
    {
        std::cout << "expression -> expression T_DIV expression" << std::endl;
    }
|
    expression T_MOD expression
    {
        std::cout << "expression -> expression T_MOD expression" << std::endl;
    }
|
    expression T_LESS expression
    {
        std::cout << "expression -> expression T_LESS expression" << std::endl;
    }
|
    expression T_GR expression
    {
        std::cout << "expression -> expression T_GR expression" << std::endl;
    }
|
    expression T_EQ expression
    {
        std::cout << "expression -> expression T_EQ expression" << std::endl;
    }
|
    expression T_AND expression
    {
        std::cout << "expression -> expression T_AND expression" << std::endl;
    }
|
    expression T_OR expression
    {
        std::cout << "expression -> expression T_OR expression" << std::endl;
    }
|
    T_NOT expression
    {
        std::cout << "expression -> T_NOT expression" << std::endl;
    }
|
    T_OPEN expression T_CLOSE
    {
        std::cout << "expression -> T_OPEN expression T_CLOSE" << std::endl;
    }
|
    T_ID T_QUESTION expression
    {
        std::cout << "expression -> T_ID T_QUESTION expression" << std::endl;
    }
;

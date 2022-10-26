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
%token T_MIDOPEN
%token T_PARALLEL
%token T_MIDCLOSE
%token T_COMMA
%token T_DUPLI
%token T_LIST
%token T_LISTEXP
%token T_PLUSEQ
%token T_INDEX
%token T_DOT



%left T_OR T_AND
%left T_EQ
%left T_LESS T_GR
%left T_QUESTION T_COLON
%left T_SHIFT
%left T_ADD T_SUB
%left T_PLUSPLUS
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

    type multi_id T_SEMICOLON
    {
        std::cout << "declaration -> type multi_id T_SEMICOLON" << std::endl;
    }
|   
    type T_LIST multi_id T_SEMICOLON
    {
        std::cout << "declaration -> type T_LIST multi_id T_SEMICOLON" << std::endl;
    }
|
    T_LESS type T_COMMA in_tuple T_GR multi_id T_SEMICOLON
    {
        std::cout << "declaration -> T_LESS type T_COMMA in_tuple T_GR multi_id T_SEMICOLON" << std::endl;
    }
;
in_tuple:
    type
    {
        std::cout << "in_tuple -> type" << std::endl;
    }
|
    type T_COMMA in_tuple
    {
        std::cout << "in_tuple -> type T_COMMA in_tuple" << std::endl;
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

multi_id:
    T_ID 
    {
        std::cout << "multi_id -> T_ID" << std::endl;
    }
|   
    T_ID T_COMMA multi_id
    {
        std::cout << "multi_id -> T_ID T_COMMA multi_id" << std::endl;
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
    T_MIDOPEN Part_statement T_PARALLEL Part_statement T_MIDCLOSE T_SEMICOLON
    {
        std::cout << "statement -> T_MIDOPEN Part_statement T_PARALLEL Part_statement T_MIDCLOSE T_SEMICOLON" << std::endl;
    }
|
    T_DUPLI statement
    {
        std::cout << "statement -> T_DUPLI statement" << std::endl;
    }
;

Part_statement:
    T_ID T_ASSIGN expression 
    {
        std::cout << "Part_statement -> T_ID T_ASSIGN expression" << std::endl;
    }
|
    T_READ T_OPEN T_ID T_CLOSE
    {
        std::cout << "Part_statement -> T_READ T_OPEN T_ID T_CLOSE" << std::endl;
    }
|
    T_WRITE T_OPEN expression T_CLOSE
    {
        std::cout << "Part_statement -> T_WRITE T_OPEN expression T_CLOSE" << std::endl;
    }
|
    branch
    {
        std::cout << "Part_statement -> branch" << std::endl;
    }
|
    loop
    {
        std::cout << "Part_statement -> loop" << std::endl;
    }
|
    T_MIDOPEN Part_statement T_PARALLEL Part_statement T_MIDCLOSE
    {
        std::cout << "Part_statement -> T_MIDOPEN Part_statement T_PARALLEL Part_statement T_MIDCLOSE" << std::endl;
    }
;

assignment:
    id T_ASSIGN expression T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_ASSIGN expression T_SEMICOLON" << std::endl;
    }
|
    T_ID T_PLUSEQ expression T_SEMICOLON
    {
        std::cout << "assignment -> T_ID T_PLUSEQ expression T_SEMICOLON" << std::endl;
    }
|
    simultan T_SEMICOLON
    {
        std::cout << "assignment -> simultan T_SEMICOLON" << std::endl;
    }
;
simultan:
    T_ID loops expression
    {
        std::cout << "simultan-> T_ID loops expression" << std::endl;
    }
;

loops:
    T_COMMA T_ID T_ASSIGN expression T_COMMA
    {
        std::cout << "loops ->  T_COMMA T_ID T_ASSIGN expression T_COMMA" << std::endl;
    }
|
    T_COMMA T_ID loops expression T_COMMA
    {
        std::cout << "loops ->  T_COMMA T_ID loops expression T_COMMA" << std::endl;
    }
;
id:
    T_ID
    {
        std::cout << "id -> T_ID " << std::endl;
    }
|
    T_ID T_INDEX
    {
        std::cout << "id -> T_ID T_INDEX " << std::endl;
    }
|
    T_ID T_DOT T_NUM
    {
        std::cout << "id -> T_ID T_DOT T_NUM " << std::endl;
    }
;

read:
    T_READ T_OPEN id T_CLOSE T_SEMICOLON
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
    T_LISTEXP
    {
        std::cout << "expression -> T_LISTEXP" << std::endl;
    }
|
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
    id
    {
        std::cout << "expression -> T_ID" << std::endl;
    }
|
    T_OPEN expression T_QUESTION expression T_COLON expression T_CLOSE
    {
        std::cout << "expression -> T_OPEN expression T_QUESTION expression T_COLON expression T_CLOSE" << std::endl;
    }
|
    expression T_SHIFT expression
    {
        std::cout << "expression -> expression T_SHIFT expression" << std::endl;
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
    expression T_PLUSPLUS expression
    {
        std::cout << "expression -> expression T_PLUSPLUS expression" << std::endl;
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
;

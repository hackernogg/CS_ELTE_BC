%baseclass-preinclude "semantics.h"

%lsp-needed

%union
{
  std::string *name;
  type *expr_type;
}

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
%token <name> T_ID
%token T_TIME
%token T_TIME_LIT
%token T_HOUR
%token T_MINUTE
%token T_MAKE_TIME
%token T_COMMA

%left T_OR T_AND
%left T_EQ
%left T_LESS T_GR
%left T_ADD T_SUB
%left T_MUL T_DIV T_MOD
%nonassoc T_NOT

%start program

%type <expr_type> expression;

%%

program:
    T_PROGRAM T_ID declarations T_BEGIN statements T_END
    {
        delete $2;
    }
;

declarations:
    // empty
    {
    }
|
    declaration declarations
    {
    }
;

declaration:
    T_INTEGER T_ID T_SEMICOLON
    {
		if( symbol_table.count(*$2) > 0 )
		{
			std::stringstream ss;
			ss << "Re-declared variable: " << *$2 << ".\n"
			<< "Line of previous declaration: " << symbol_table[*$2].decl_row << std::endl;
			error( ss.str().c_str() );
		}
		symbol_table[*$2] = var_data( d_loc__.first_line, integer );
        delete $2;
    }
|
    T_BOOLEAN T_ID T_SEMICOLON
    {
		if( symbol_table.count(*$2) > 0 )
		{
			std::stringstream ss;
			ss << "Re-declared variable: " << *$2 << ".\n"
			<< "Line of previous declaration: " << symbol_table[*$2].decl_row << std::endl;
			error( ss.str().c_str() );
		}
		symbol_table[*$2] = var_data( d_loc__.first_line, boolean );
        delete $2;
    }
|
    T_TIME T_ID T_SEMICOLON
    {
        if( symbol_table.count(*$2) > 0 )
		{
			std::stringstream ss;
			ss << "Re-declared variable: " << *$2 << ".\n"
			<< "Line of previous declaration: " << symbol_table[*$2].decl_row << std::endl;
			error( ss.str().c_str() );
		}
		symbol_table[*$2] = var_data( d_loc__.first_line, t_time );
        delete $2;
    }
;

statements:
    statement
    {
    }
|
    statement statements
    {
    }
;

statement:
    T_SKIP T_SEMICOLON
    {
    }
|
    assignment
    {
    }
|
    read
    {
    }
|
    write
    {
    }
|
    branch
    {
    }
|
    loop
    {
    }
;

assignment:
    T_ID T_ASSIGN expression T_SEMICOLON
    {
		if( symbol_table.count(*$1) == 0 )
		{
			std::stringstream ss;
			ss << "Undeclared variable: " << *$1 << std::endl;
			error( ss.str().c_str() );
		}
		if(symbol_table[*$1].decl_type != *$3)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
        delete $1;
        delete $3;
    }
;

read:
    T_READ T_OPEN T_ID T_CLOSE T_SEMICOLON
    {
		if( symbol_table.count(*$3) == 0 )
		{
			std::stringstream ss;
			ss << "Undeclared variable: " << *$3 << std::endl;
			error( ss.str().c_str() );
		}
        delete $3;
    }
;

write:
    T_WRITE T_OPEN expression T_CLOSE T_SEMICOLON
    {
        delete $3;
    }
;

branch:
    T_IF expression T_THEN statements T_ENDIF
    {
		if(*$2 != boolean)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
        delete $2;
    }
|
    T_IF expression T_THEN statements T_ELSE statements T_ENDIF
    {
		if(*$2 != boolean)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
        delete $2;
    }
;

loop:
    T_WHILE expression T_DO statements T_DONE
    {
		if(*$2 != boolean)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
        delete $2;
    }
;

expression:
    T_NUM
    {
		$$ = new type(integer);
    }
|
    T_TRUE
    {
		$$ = new type(boolean);
    }
|
    T_FALSE
    {
		$$ = new type(boolean);
    }
|
    T_TIME_LIT 
    {
        $$ = new type(t_time);
    }
|
    T_ID
    {
		if( symbol_table.count(*$1) == 0 )
		{
			std::stringstream ss;
			ss << "Undeclared variable: " << *$1 << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(symbol_table[*$1].decl_type);
        delete $1;
    }
|
    expression T_ADD expression
    {
		if((*$1 != integer && *$1 != t_time) || *$3 != integer)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
        if(*$1 == integer && *$3 == integer)
        {
            $$ = new type(integer);
            delete $1;
            delete $3;
        }
        if(*$1 == t_time && *$3 == integer)
        {
            $$ = new type(t_time);
            delete $1;
            delete $3;
        }

    }
|
    expression T_SUB expression
    {
		if((*$1 != integer && *$1 != t_time) || *$3 != integer)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
        if(*$1 == integer && *$3 == integer)
        {
            $$ = new type(integer);
            delete $1;
            delete $3;
        }
        if(*$1 == t_time && *$3 == integer)
        {
            $$ = new type(t_time);
            delete $1;
            delete $3;
        }
    }
|
    expression T_MUL expression
    {
		if(*$1 != integer || *$3 != integer)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(integer);
        delete $1;
        delete $3;
    }
|
    expression T_DIV expression
    {
		if(*$1 != integer || *$3 != integer)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(integer);
        delete $1;
        delete $3;
    }
|
    expression T_MOD expression
    {
		if(*$1 != integer || *$3 != integer)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(integer);
        delete $1;
        delete $3;
    }
|
    expression T_LESS expression
    {
		if(*$1 != integer || *$3 != integer)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
    expression T_GR expression
    {
		if(*$1 != integer || *$3 != integer)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
    expression T_EQ expression
    {
		if(*$1 != *$3 || *$1 == t_time || *$3 == t_time)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
    expression T_AND expression
    {
		if(*$1 != boolean || *$3 != boolean)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
    expression T_OR expression
    {
		if(*$1 != boolean || *$3 != boolean)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
    T_NOT expression
    {
		if(*$2 != boolean)
		{
		   std::stringstream ss;
		   ss << d_loc__.first_line << ": Type error." << std::endl;
		   error( ss.str().c_str() );
		}
		$$ = new type(boolean);
        delete $2;
    }
|
    T_OPEN expression T_CLOSE
    {
		$$ = new type(*$2);
        delete $2;
    }
|
    T_HOUR T_OPEN expression T_CLOSE
    {
        if(*$3 != t_time)
        {
            std::stringstream ss;
		    ss << d_loc__.first_line << ": Type error." << std::endl;
		    error( ss.str().c_str() );
        }
        $$ = new type(integer);
        delete $3;
    }
|
    T_MINUTE T_OPEN expression T_CLOSE
    {
        if(*$3 != t_time)
        {
            std::stringstream ss;
		    ss << d_loc__.first_line << ": Type error." << std::endl;
		    error( ss.str().c_str() );
        }
        $$ = new type(integer);
        delete $3;
    }
|
    T_MAKE_TIME T_OPEN expression T_COMMA expression T_CLOSE
    {
        if(*$3 != integer || *$5 != integer)
        {
            std::stringstream ss;
		    ss << d_loc__.first_line << ": Type error." << std::endl;
		    error( ss.str().c_str() );
        }
        $$ = new type(t_time);
        delete $3;
        delete $5;
    }
;

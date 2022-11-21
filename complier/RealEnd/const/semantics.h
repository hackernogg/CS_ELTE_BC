#ifndef SEMANTICS_H
#define SEMANTICS_H

#include<iostream>
#include<string>
#include<map>
#include<sstream>

enum type { integer, boolean };

struct var_data {
	int decl_row;
	type decl_type;
	bool is_const;
	bool is_assigned;
	var_data(){}
	var_data(int i, type t, bool c, bool a)
	{
		decl_row = i;
		decl_type = t;
		is_const = c;
		is_assigned = a;
	}
};

#endif

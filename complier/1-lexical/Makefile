while: lex.yy.cc while.cc 
	g++ lex.yy.cc while.cc -o while

lex.yy.cc: while.l
	flex while.l

.PHONY: clean
clean:
	rm -f lex.yy.cc while 

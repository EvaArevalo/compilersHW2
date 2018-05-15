# makefile
# creates "scanner" from "scanner.l" and "test.c"

CC=gcc
LEX=flex
PARS=byacc

parser: lex.yy.c y.tab.c
		$(CC) -o parser lex.yy.c y.tab.c

y.tab.c: parser.y
		 $(PARS) -d --verbose parser.y

lex.yy.c: scanner.l
		$(LEX) scanner.l

clean:
		$(RM) *.o scanner.o lex.yy.c y.tab.c

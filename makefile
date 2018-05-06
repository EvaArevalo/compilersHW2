# makefile
# creates "scanner" from "scanner.l" and "test.c"

CC=gcc
LEX=flex

scanner: lex.yy.c
		$(CC) -o $@ $(LDFLAGS) $^

lex.yy.c: scanner.l
		$(LEX) $(LFLAGS) -o $@ $^

clean:
		$(RM) *.o scanner.o lex.yy.c

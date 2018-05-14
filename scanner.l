%{
#include "y.tab.h"
#include <stdio.h>

int	printTokenOn=1;
int	printSourceOn=1;
int 	lineCount=0;
int	wordCount=0;
int 	numStrings = 5;
char	**lineContents = NULL; 
FILE*	f;

void addWordToLine();
void endOfLine();
void comment();
int yywrap();
void lexerError();
void freeLineContents();

%}

%x PRAGMA ERROR SINGLECOMMENT MULTICOMMENT

Whitespace  [ \t]*
Letter	    [a-zA-Z]
Digit 	    [0-9]
Operator    [\+\-\*/%><=!]
Punctuation [:;,\.\[\]\(\)\{\}\?]
Exponent    [Ee][+-]?{Digit}+

Invalidnum  ({Integer}|{Double}|{Sciint}|{Scidouble})+({Identifier}|{Exponent}|\.)
Integer	    {Digit}+
Double	    {Integer}?[\.]{Integer}
Scidouble   {Double}{Exponent}
Sciint	    {Integer}{Exponent}

Char        \'[ -~]\'
String	    \"[ -~]+\"
Identifier  [_a-zA-Z][_a-zA-Z0-9]*
Pragma	    [#]

%%

{Pragma}			{addWordToLine(); BEGIN(PRAGMA);}
<PRAGMA>"pragma source on"	{printSourceOn=1; addWordToLine();}
<PRAGMA>"pragma source off"	{printSourceOn=0; addWordToLine();} 
<PRAGMA>"pragma token on"	{printTokenOn=1; addWordToLine();} 
<PRAGMA>"pragma token off"	{printTokenOn=0; addWordToLine();}
<PRAGMA>.			{freeLineContents();
  				lineContents = (char**)malloc(sizeof(char*)*numStrings); 
 				addWordToLine();
				 BEGIN(ERROR);}
<PRAGMA>\n			{endOfLine(); BEGIN(INITIAL);}

<ERROR>.			{addWordToLine();}
<ERROR>\n			{lexerError(); BEGIN(INITIAL);}


"/*"				{addWordToLine(); BEGIN(MULTICOMMENT);}
<MULTICOMMENT>[^*\n \t]*	{addWordToLine();} /* eat anythong that's not a '*' */
<MULTICOMMENT>"*"+[^*/\n]*  	{addWordToLine();} /* eat '*' not followed by '/' */
<MULTICOMMENT>{Whitespace}	{addWordToLine();}
<MULTICOMMENT>\n		{endOfLine();}
<MULTICOMMENT>"*"+"/" 		{addWordToLine(); BEGIN(INITIAL);}

"//"				{addWordToLine(); BEGIN(SINGLECOMMENT);}  
<SINGLECOMMENT>.		{addWordToLine(); }	
<SINGLECOMMENT>\n 		{endOfLine();BEGIN(INITIAL);}

void		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return VOID;}
int			{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return INT;}
double   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return DOUBLE;}
bool   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return BOOL;}
char   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return CHAR;}
null   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return K_NULL;}
for   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FOR;}
while   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return WHILE;}
do   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return DO;}
if   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return IF;}
else   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return ELSE;}
switch 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return SWITCH;}
return   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return RETURN;}
break   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return BREAK;}
continue 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return CONTINUE;}
const   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return CONST;}
true   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return TRUE;}
false   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FALSE;}
struct  	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return STRUCT;}
case   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return CASE;}
default 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return DEFAULT;}

fclose 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FCLOSE;}
clearerr 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return CLEARERR;}
ferror 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FERROR;}
fflush 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FFLUSH;}
fgetpos 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FGETPOS;}
fopen 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FOPEN;}
fread 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FREAD;}
freopen 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FREOPEN;}
fseek 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FSEEK;}
ftell 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FTELL;}
fwrite 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FWRITE;}
remove 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return REMOVE;}
rename 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return RENAME;}
rewind		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return REWIND;}
setbuf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return SETBUF;}
setvbuf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return SETVBUF;}
tmpfile 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return TMPFILE;}
tmpnam 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return TMPNAM;}
fprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FPRINTF;}
printf	 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return PRINTF;}
sprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return SPRINTF;}
vfprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return VFPRINTF;}
vprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return VPRINTF;}
vsprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return VSPRINTF;}
fscanf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FSCANF;}
scanf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return SCANF;}
sscanf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return SSCANF;}
fgetc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FGETC;}
fgets		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FGETS;}
fputc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FPUTC;}
fputs 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FPUTS;}
getc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return GETC;}
getchar 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return GETCHAR;}
gets 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return GETS;}
putc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return PUTC;}
putchar 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return PUTCHAR;}
puts 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return PUTS;}
ungetc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return UNGETC;}
perror		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return PERROR;}
ffprintf	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine(); return FFPRINTF;}

"++"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return INC_OP;}
"--"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return DEC_OP;}
"<="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return LE_OP;}
">="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return GE_OP;}
"=="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return EQ_OP;}
"!="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return NE_OP;}
"&&"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return AND_OP;}
"||"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return OR_OP;}
"&"			{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return POINTER_OP;}

"+="			{if(printTokenOn==1) printf("#assign:%s\n",yytext);  addWordToLine(); return ADD_ASSIGN;}
"-="			{if(printTokenOn==1) printf("#assign:%s\n",yytext);  addWordToLine(); return SUB_ASSIGN;}
"*="			{if(printTokenOn==1) printf("#assign:%s\n",yytext);  addWordToLine(); return MUL_ASSIGN;}
"/="			{if(printTokenOn==1) printf("#assign:%s\n",yytext);  addWordToLine(); return DIV_ASSIGN;}

{Whitespace}	{addWordToLine();}
{Operator}		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine(); return *yytext;}
{Punctuation}		{if(printTokenOn==1) printf("#punc:%s\n",yytext);  addWordToLine(); return *yytext;}
{Scidouble}		{if(printTokenOn==1) printf("#sci:%s\n",yytext);  addWordToLine(); return NUMBER_SCI;}
{Sciint}		{if(printTokenOn==1) printf("#sci:%s\n",yytext);  addWordToLine(); return NUMBER_SCI;}
{Double}		{if(printTokenOn==1) printf("#double:%s\n",yytext);  addWordToLine(); return NUMBER_DOUBLE;}
{Integer}		{if(printTokenOn==1) printf("#integer:%s\n",yytext);  addWordToLine(); return NUMBER_INTEGER;}
{Char}			{if(printTokenOn==1) printf("#char:%s\n",yytext);  addWordToLine(); return CHARACTER;}
{Identifier}	{if(printTokenOn==1) printf("#id:%s\n",yytext);  addWordToLine(); return IDENTIFIER;}
{String}		{char *stringtext= (char*)malloc(sizeof(char)*(yyleng-1));
			strncpy(stringtext,&yytext[1],yyleng-2);
			strncpy(&stringtext[yyleng-2],&yytext[yyleng],1);
			printf("#string:%s\n",stringtext);
			addWordToLine();
			free(stringtext);
			return STRING;}
{Invalidnum}		{freeLineContents();
  			lineContents = (char**)malloc(sizeof(char*)*numStrings); 
 			addWordToLine();
			BEGIN(ERROR);
			return INVALIDNUM;}
\n 			{endOfLine();}
.			{freeLineContents();
  			lineContents = (char**)malloc(sizeof(char*)*numStrings); 
 			addWordToLine();
			BEGIN(ERROR);}


%%

/*-----------------------
addWordToLine() Adds word to line, dynamically allocates more space if 
needed
------------------------*/
void addWordToLine(){
	if (wordCount>=numStrings-1){
		numStrings*=2;
		lineContents=realloc(lineContents,numStrings*sizeof(lineContents));
	}
	lineContents[wordCount] = (char*) malloc(sizeof(char) * yyleng + 1);
	strcpy(lineContents[wordCount],yytext);
	wordCount++;
}

/*-----------------------
endOfLine() Flushes a synctactically correct line to the file
------------------------*/
void endOfLine(){
	//print line
	lineCount++;

	if(printSourceOn==1){
		printf("%d:", lineCount);
		int j;
		for(j=0;j<wordCount;j++)
			printf("%s",lineContents[j]);
		printf("\n");
	}

	//free and reallocate, reset vars
	freeLineContents();
	lineContents = (char**) malloc(sizeof(char*) * numStrings);
}


int yywrap(){
	return 1; /*eof*/
}

/*-----------------------
lexerError() Prints error to stderr  
------------------------*/
void lexerError(char *message){
	fprintf(stderr, "Error at line %d: ",lineCount+1);
	int j;
	for(j=0;j<wordCount;j++)
		fprintf(stderr,"%s",lineContents[j]);
	fprintf(stderr,"\n");
	//free and reallocate, reset vars
	freeLineContents();
	exit(1);
}

/*-----------------------
addWordToLine() Clean up dynamically allocated array lineContents() 
------------------------*/
void freeLineContents(){

	int i;
	for(i=0;i<wordCount;i++)
		free(lineContents[i]);
	free(lineContents);
	numStrings=5;
	wordCount=0;
}

void yyerror(const char *msg ) {	
	fprintf( stderr, "*** Error at line %d:", lineCount+1);
	int j;
	for(j=0;j<wordCount;j++)
		fprintf(stderr,"%s",lineContents[j]);
	fprintf(stderr,"\n");
	fprintf( stderr, "\n" );
	fprintf( stderr, "Unmatched token: %s\n", yytext );
	fprintf( stderr, "*** syntax error\n");	
	freeLineContents();
	exit(-1);
}
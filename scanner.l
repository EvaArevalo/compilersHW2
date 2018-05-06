%{
//#include "y.tab.h"
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
void yyerror();
void freeLineContents();

%}

%x PRAGMA ERROR SINGLECOMMENT MULTICOMMENT

Whitespace  [ \t]*
Letter	    [a-zA-Z]
Digit 	    [0-9]
Operator    [\+\-\*/%><=!]
Punctuation [:;,\.\[\]\(\)\{\}]
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
<ERROR>\n			{yyerror(); BEGIN(INITIAL);}


"/*"				{addWordToLine(); BEGIN(MULTICOMMENT);}
<MULTICOMMENT>[^*\n \t]*	{addWordToLine();} /* eat anythong that's not a '*' */
<MULTICOMMENT>"*"+[^*/\n]*  	{addWordToLine();} /* eat '*' not followed by '/' */
<MULTICOMMENT>{Whitespace}	{addWordToLine();}
<MULTICOMMENT>\n		{endOfLine();}
<MULTICOMMENT>"*"+"/" 		{addWordToLine(); BEGIN(INITIAL);}

"//"				{addWordToLine(); BEGIN(SINGLECOMMENT);}  
<SINGLECOMMENT>.		{addWordToLine();}	
<SINGLECOMMENT>\n 		{endOfLine();BEGIN(INITIAL);}

void		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
int			{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
double   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
bool   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
char   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
null   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
for   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
while   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
do   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
if   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
else   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
switch 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
return   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
break   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
continue 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
const   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
true   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
false   	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
struct  	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
case   		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
default 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}

fclose 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
clearerr 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
ferror 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fflush 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fgetpos 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fopen 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fread 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
freopen 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fseek 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
ftell 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fwrite 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
remove 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
rename 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
rewind		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
setbuf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
setvbuf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
tmpfile 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
tmpnam 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
printf	 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
sprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
vfprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
vprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
vsprintf 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fscanf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
scanf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
sscanf 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fgetc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fgets		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fputc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
fputs 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
getc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
getchar 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
gets 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
putc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
putchar 	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
puts 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
ungetc 		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
perror		{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}
ffprintf	{if(printTokenOn==1) printf("#key:%s\n",yytext);  addWordToLine();}

"++"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
"--"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
"<="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
">="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
"=="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
"!="		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
"&&"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
"||"		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
"&"			{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}

{Whitespace}	{addWordToLine();}
{Operator}		{if(printTokenOn==1) printf("#op:%s\n",yytext);  addWordToLine();}
{Punctuation}		{if(printTokenOn==1) printf("#punc:%s\n",yytext);  addWordToLine();}
{Scidouble}		{if(printTokenOn==1) printf("#sci:%s\n",yytext);  addWordToLine(); }
{Scidouble}		{if(printTokenOn==1) printf("#sci:%s\n",yytext);  addWordToLine(); }
{Sciint}		{if(printTokenOn==1) printf("#sci:%s\n",yytext);  addWordToLine(); }
{Double}		{if(printTokenOn==1) printf("#double:%s\n",yytext);  addWordToLine(); }
{Integer}		{if(printTokenOn==1) printf("#integer:%s\n",yytext);  addWordToLine(); }
{Char}			{if(printTokenOn==1) printf("#char:%s\n",yytext);  addWordToLine();}
{Identifier}	{if(printTokenOn==1) printf("#id:%s\n",yytext);  addWordToLine();}
{String}		{char *stringtext= (char*)malloc(sizeof(char)*(yyleng-1));
			strncpy(stringtext,&yytext[1],yyleng-2);
			strncpy(&stringtext[yyleng-2],&yytext[yyleng],1);
			printf("#string:%s\n",stringtext);
			addWordToLine();
			free(stringtext);}
{Invalidnum}		{freeLineContents();
  			lineContents = (char**)malloc(sizeof(char*)*numStrings); 
 			addWordToLine();
			BEGIN(ERROR);}
\n 			{endOfLine();}
.			{freeLineContents();
  			lineContents = (char**)malloc(sizeof(char*)*numStrings); 
 			addWordToLine();
			BEGIN(ERROR);}


%%

/*-----------------------
main() set yyin() as the argument passed on command line and
outputs to file "tokens", calls lexer, closes and  cleans up 
------------------------*/
int main(int argc, char*argv[]){
  ++argv;
  --argc;	/*skip over program name*/

  if (0<argc){
  	yyin = fopen(argv[0], "r");
  } else {
  	yyin=stdin;
  }
  
  //f = fopen("tokens","w");
  //f = fopen("tokens","w");

  lineContents = (char**)malloc(sizeof(char*)*numStrings);  
  yylex();
  //fclose(f);
  freeLineContents();
  return 0;
} 

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
yyerror() Prints error to stderr  
------------------------*/
void yyerror(char *message){
	fprintf(stderr, "Error at line %d: ",lineCount+1);
	int j;
	for(j=0;j<wordCount;j++)
		fprintf(stderr,"%s",lineContents[j]);
	fprintf(stderr,"\n");
	//free and reallocate, reset vars
	freeLineContents();
	lineContents = (char**) malloc(sizeof(char*) * numStrings);
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


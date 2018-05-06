%{
#include <stdio.h>

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
<PRAGMA>"pragma source on"	{addWordToLine();}
<PRAGMA>"pragma source off"+\n	{freeLineContents();
  				lineContents = (char**)malloc(sizeof(char*)*numStrings);
				BEGIN(INITIAL);} 
<PRAGMA>"pragma token on"	{addWordToLine();} 
<PRAGMA>"pragma token off"	{addWordToLine();}
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

void			{printf("#key:%s\n",yytext);  addWordToLine();}
int			{printf("#key:%s\n",yytext);  addWordToLine();}
double   		{printf("#key:%s\n",yytext);  addWordToLine();}
bool   			{printf("#key:%s\n",yytext);  addWordToLine();}
char   			{printf("#key:%s\n",yytext);  addWordToLine();}
null   			{printf("#key:%s\n",yytext);  addWordToLine();}
for   			{printf("#key:%s\n",yytext);  addWordToLine();}
while   		{printf("#key:%s\n",yytext);  addWordToLine();}
do   			{printf("#key:%s\n",yytext);  addWordToLine();}
if   			{printf("#key:%s\n",yytext);  addWordToLine();}
else   			{printf("#key:%s\n",yytext);  addWordToLine();}
switch 			{printf("#key:%s\n",yytext);  addWordToLine();}
return   		{printf("#key:%s\n",yytext);  addWordToLine();}
break   		{printf("#key:%s\n",yytext);  addWordToLine();}
continue 		{printf("#key:%s\n",yytext);  addWordToLine();}
const   		{printf("#key:%s\n",yytext);  addWordToLine();}
true   			{printf("#key:%s\n",yytext);  addWordToLine();}
false   		{printf("#key:%s\n",yytext);  addWordToLine();}
struct  		{printf("#key:%s\n",yytext);  addWordToLine();}
case   			{printf("#key:%s\n",yytext);  addWordToLine();}
default 		{printf("#key:%s\n",yytext);  addWordToLine();}

fclose 			{printf("#key:%s\n",yytext);  addWordToLine();}
clearerr 		{printf("#key:%s\n",yytext);  addWordToLine();}
feof 			{printf("#key:%s\n",yytext);  addWordToLine();}
ferror 			{printf("#key:%s\n",yytext);  addWordToLine();}
fflush 			{printf("#key:%s\n",yytext);  addWordToLine();}
fgetpos 		{printf("#key:%s\n",yytext);  addWordToLine();}
fopen 			{printf("#key:%s\n",yytext);  addWordToLine();}
fread 			{printf("#key:%s\n",yytext);  addWordToLine();}
freopen 		{printf("#key:%s\n",yytext);  addWordToLine();}
fseek 			{printf("#key:%s\n",yytext);  addWordToLine();}
fsetpos 		{printf("#key:%s\n",yytext);  addWordToLine();}
ftell 			{printf("#key:%s\n",yytext);  addWordToLine();}
fwrite 			{printf("#key:%s\n",yytext);  addWordToLine();}
remove 			{printf("#key:%s\n",yytext);  addWordToLine();}
rename 			{printf("#key:%s\n",yytext);  addWordToLine();}
rewind			{printf("#key:%s\n",yytext);  addWordToLine();}
setbuf 			{printf("#key:%s\n",yytext);  addWordToLine();}
setvbuf 		{printf("#key:%s\n",yytext);  addWordToLine();}
tmpfile 		{printf("#key:%s\n",yytext);  addWordToLine();}
tmpnam 			{printf("#key:%s\n",yytext);  addWordToLine();}
fprintf 		{printf("#key:%s\n",yytext);  addWordToLine();}
printf	 		{printf("#key:%s\n",yytext);  addWordToLine();}
sprintf 		{printf("#key:%s\n",yytext);  addWordToLine();}
vfprintf 		{printf("#key:%s\n",yytext);  addWordToLine();}
vprintf 		{printf("#key:%s\n",yytext);  addWordToLine();}
vsprintf 		{printf("#key:%s\n",yytext);  addWordToLine();}
fscanf 			{printf("#key:%s\n",yytext);  addWordToLine();}
scanf 			{printf("#key:%s\n",yytext);  addWordToLine();}
sscanf 			{printf("#key:%s\n",yytext);  addWordToLine();}
fgetc 			{printf("#key:%s\n",yytext);  addWordToLine();}
fgets			{printf("#key:%s\n",yytext);  addWordToLine();}
fputc 			{printf("#key:%s\n",yytext);  addWordToLine();}
fputs 			{printf("#key:%s\n",yytext);  addWordToLine();}
getc 			{printf("#key:%s\n",yytext);  addWordToLine();}
getchar 		{printf("#key:%s\n",yytext);  addWordToLine();}
gets 			{printf("#key:%s\n",yytext);  addWordToLine();}
putc 			{printf("#key:%s\n",yytext);  addWordToLine();}
putchar 		{printf("#key:%s\n",yytext);  addWordToLine();}
puts 			{printf("#key:%s\n",yytext);  addWordToLine();}
ungetc 			{printf("#key:%s\n",yytext);  addWordToLine();}
perror			{printf("#key:%s\n",yytext);  addWordToLine();}
ffprintf		{printf("#key:%s\n",yytext);  addWordToLine();}

"++"			{printf("#op:%s\n",yytext);  addWordToLine();}
"--"			{printf("#op:%s\n",yytext);  addWordToLine();}
"<="			{printf("#op:%s\n",yytext);  addWordToLine();}
">="			{printf("#op:%s\n",yytext);  addWordToLine();}
"=="			{printf("#op:%s\n",yytext);  addWordToLine();}
"!="			{printf("#op:%s\n",yytext);  addWordToLine();}
"&&"			{printf("#op:%s\n",yytext);  addWordToLine();}
"||"			{printf("#op:%s\n",yytext);  addWordToLine();}

{Whitespace}		{addWordToLine();}
{Operator}		{printf("#op:%s\n",yytext);  addWordToLine();}
{Punctuation}		{printf("#punc:%s\n",yytext);  addWordToLine();}
{Scidouble}		{printf("#sci:%s\n",yytext);  addWordToLine(); }
{Sciint}		{printf("#sci:%s\n",yytext);  addWordToLine(); }
{Double}		{printf("#double:%s\n",yytext);  addWordToLine(); }
{Integer}		{printf("#integer:%s\n",yytext);  addWordToLine(); }
{Char}			{printf("#char:%s\n",yytext);  addWordToLine();}
{Identifier}		{printf("#id:%s\n",yytext);  addWordToLine();}
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

	printf("%d:", lineCount);
	int j;
	for(j=0;j<wordCount;j++)
		printf("%s",lineContents[j]);
	printf("\n");

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
	fprintf(stderr, "Error at line %d: ",lineCount);
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


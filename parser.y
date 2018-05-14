%{
#include <stdio.h>
int yylex();
int yyerror(char* msg);
%}

%token IDENTIFIER NUMBER_SCI NUMBER_DOUBLE NUMBER_INTEGER CHARACTER
%token VOID INT DOUBLE BOOL CHAR STRING K_NULL FOR WHILE DO IF ELSE SWITCH RETURN BREAK 
%token CONTINUE CONST TRUE FALSE STRUCT CASE DEFAULT
%token FCLOSE CLEARERR FERROR FFLUSH FGETPOS FOPEN FREAD FREOPEN FSEEK FTELL FWRITE
%token REMOVE RENAME REWIND SETBUF SETVBUF TMPFILE TMPNAM FPRINTF PRINTF SPRINTF 
%token VFPRINTF VPRINTF VSPRINTF FSCANF SCANF SSCANF FGETC FGETS FPUTC FPUTS GETC
%TOKEN GETCHAR GETS PUTC PUTCHAR PUTS UNGETC PERROR FFPRINTF
%token INC_OP DEC_OP LE_OP GE_OP EQ_OP NE_OP AND_OP OR_OP POINTER_OP
%token ADD_ASSIGN SUB_ASSIGN DIV_ASSIGN MUL_ASSIGN
%token INVALIDNUM

/*%nonassoc ELSE*/

%start valid_structure
%%

valid_structure
	: global_declarations function_definition
	;

global_declarations
	: /* empty */
	| global_declarations external_declaration
	;

external_declaration
	: function_definition
	| declaration
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

declaration
	: declaration_const /* vars */
	| declaration_no_const /* array */
	;

declaration_const
	: declaration_specifiers_const ';'
	| declaration_specifiers_const init_declarator_list_const ';'
	;

declaration_specifiers_const
	: type_qualifier scalar_type_specifier
	;

type_qualifier
	: CONST
	;

scalar_type_specifier
	: INT 
	| DOUBLE 
	| BOOL 
	| CHAR
	;

init_declarator_list_const
	: init_declarator_const
	| init_declarator_list_const ',' init_declarator_const
	;

init_declarator_const
	: declarator_const '=' initializer
	| declarator_const
	;

declarator_const
	: direct_declarator_const
	;

direct_declarator_const
	: IDENTIFIER
	| '(' declarator_const ')'
	| direct_declarator_const '(' ')'
	| direct_declarator_const '(' parameter_list ')'
	| direct_declarator_const '(' identifier_list ')'
	;

declaration_no_const
	: declaration_specifiers_no_const ';'
	| declaration_specifiers_no_const init_declarator_list_no_const ';'
	;

declaration_specifiers_no_const
	: scalar_type_specifier
	| scalar_type_specifier declaration_specifiers_no_const

init_declarator_list_no_const
	: init_declarator_no_const
	| init_declarator_list_no_const ',' init_declarator_no_const

init_declarator_no_const
	: declarator_no_const '=' initializer
	| declarator_no_const
	;

declarator_no_const
	: direct_declarator_no_const
	;

direct_declarator_no_const
	: IDENTIFIER
	| '(' declarator_no_const ')'
	| direct_declarator_no_const '(' ')'
	| direct_declarator_no_const '(' parameter_list ')'
	| direct_declarator_no_const '(' identifier_list ')'
	;

function_definition
	: declaration_specifiers_no_const declarator_no_const declaration_list compound_statement
	| declaration_specifiers_no_const declarator_no_const compound_statement
	| VOID declarator_no_const declaration_list compound_statement
	| VOID declarator_no_const compound_statement
	;

initializer
	: '{' '}'
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	| assignment_expression_no_func
	;

initializer_list
	: designation  initializer
	| initializer
	| initializer_list ',' designation
	| initializer_list ',' initializer
	;

designation
	: designator_list '='
	;

designator_list
	: designator
	| designator_list designator
	;

designator
	: '.' IDENTIFIER
	;	

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	;

parameter_declaration
	: declaration_specifiers_no_const declarator_no_const
	| declaration_specifiers_no_const
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	;

compound_statement
	: '{' '}'
	| '{' block_item_list '}'
	;

block_item_list
	: global_declarations statement_group
	;

statement_group
	: /*empty*/
	| statement_group statement
	;

statement
	: compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

jump_statement
	: CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'

expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	| SWITCH '(' identifier_list ')' '{'switch_statement'}';

switch_statement
	: case_group
	| case_group default_statement
	;

case_group
	: CASE literal_constant ':' statement_group
	;

default_statement
	: DEFAULT ':' statement_group
	;

literal_constant
	: NUMBER_INTEGER
	| CHAR
	;

iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';'
	| FOR '(' expression_statement expression_statement ')' statement
	| FOR '(' expression_statement expression_statement expression ')' statement
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

assignment_expression
	: logical_or_expression
	| unary_expression '=' assignment_expression
	;

assignment_expression_no_func
	: logical_or_expression_no_func
	| unary_expression_no_func '=' assignment_expression_no_func
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;

logical_and_expression
	: and_expression
	| logical_and_expression AND_OP and_expression
	;

and_expression
	: equality_expression
	| and_expression POINTER_OP equality_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

relational_expression
	: additive_expression
	| relational_expression '>' additive_expression
	| relational_expression '<' additive_expression
	| relational_expression GE_OP additive_expression
	| relational_expression LE_OP additive_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

multiplicative_expression
	: unary_expression
	| multiplicative_expression '*' unary_expression
	| multiplicative_expression '/' unary_expression
	| multiplicative_expression '%' unary_expression
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression
	| DEC_OP unary_expression
	| unary_operator unary_expression
	;

logical_or_expression_no_func
	: logical_and_expression_no_func
	| logical_or_expression_no_func OR_OP logical_and_expression_no_func
	;

logical_and_expression_no_func
	: and_expression_no_func
	| logical_and_expression_no_func AND_OP and_expression_no_func
	;

and_expression_no_func
	: equality_expression_no_func
	| and_expression_no_func POINTER_OP equality_expression_no_func
	;

equality_expression_no_func
	: relational_expression_no_func
	| equality_expression_no_func EQ_OP relational_expression_no_func
	| equality_expression_no_func NE_OP relational_expression_no_func
	;

relational_expression_no_func
	: additive_expression_no_func
	| relational_expression_no_func '>' additive_expression_no_func
	| relational_expression_no_func '<' additive_expression_no_func
	| relational_expression_no_func GE_OP additive_expression_no_func
	| relational_expression_no_func LE_OP additive_expression_no_func
	;

additive_expression_no_func
	: multiplicative_expression_no_func
	| additive_expression_no_func '+' multiplicative_expression_no_func
	| additive_expression_no_func '-' multiplicative_expression_no_func
	;

multiplicative_expression_no_func
	: unary_expression_no_func
	| multiplicative_expression_no_func '*' unary_expression_no_func
	| multiplicative_expression_no_func '/' unary_expression_no_func
	| multiplicative_expression_no_func '%' unary_expression_no_func
	;

unary_expression_no_func
	: postfix_expression_no_func
	| INC_OP unary_expression_no_func
	| DEC_OP unary_expression_no_func
	| unary_operator unary_expression_no_func
	;

postfix_expression_no_func
	: primary_expression_no_func
	| postfix_expression_no_func  '[' ']'
	| postfix_expression_no_func '.' IDENTIFIER
	| postfix_expression_no_func INC_OP
	| postfix_expression_no_func DEC_OP
	;

primary_expression_no_func
	: IDENTIFIER
	| constant
	| STRING
	| '(' expression ')'
	;

unary_operator
	: '&'
	| '+'
	| '-'
	| '!'
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression POINTER_OP IDENTIFIER
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

primary_expression
	: IDENTIFIER
	| constant
	| STRING
	| '(' expression ')'
	;

constant
	: NUMBER_INTEGER
	| NUMBER_DOUBLE
	| NUMBER_SCI
	| CHARACTER
	; 

%% 
#include <stdio.h>
#include <stdlib.h>

extern int lineCount;
extern int yytext[];
extern char** lineContents;
extern numStrings;
extern wordCount;
extern void freeLineContents();

int main(int argc, char*argv[]){
  ++argv;
  --argc;	/*skip over program name*/

  lineContents = (char**)malloc(sizeof(char*)*numStrings); 

  /*if (0<argc){
  	yyin = fopen(argv[0], "r");
  } else {
  	yyin=stdin;
  }*/
 
	yyparse();
	printf("No Syntax error!\n");
	freeLineContents();
	return 0;
}

%token IDENTIFIER NUMBER_SCI NUMBER_DOUBLE NUMBER_INTEGER CHARACTER
%token VOID INT DOUBLE BOOL CHAR NULL FOR WHILE DO IF ELSE SWITCH RETURN BREAK 
%token CONTINUE CONST TRUE FALSE STRUCT CASE DEFAULT
%token FCLOSE CLEARERR FERROR FFLUSH FGETPOS FOPEN FREAD FREOPEN FSEEK FTELL FWRITE
%token REMOVE RENAME REWIND SETBUF SETVBUF TMPFILE TMPNAM FPRINTF PRINTF SPRINTF 
%token VFPRINTF VPRINTF VSPRINTF FSCANF SCANF SSCANF FGETC FGETS FPUTC FPUTS GETC
%TOKEN GETCHAR GETS PUTC PUTCHAR PUTS UNGETC PERROR FFPRINTF
%token INC_OP DEC_OP LE_OP GE_OP EQ_OP NE_OP AND_OP OR_OP POINTER_OP
%token ADD_ASSIGN SUB_ASSIGN DIV_ASSIGN MUL_ASSIGN
%token INVALIDNUM

%% start valid_structure

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
	: CONST scalar_type_specifier
	;

type_specifier
	: VOID
	| scalar_type
	| structured_type
	;

scalar_type_specifier
	: INT 
	| DOUBLE 
	| BOOL 
	| CHAR
	;

structured_type
	: Array
	;

init_declarator_list_const
	: init_declarator_const
	| init_declarator_list_const ';' init_declarator_const
	;

init_declarator_const
	: declarator_const '=' initializer
	| declarator_const
	;

declarator_const
	: IDENTIFIER
	| '(' declarator ')'
	| declarator '(' ')'
	| declarator '(' parameter_list ')'
	| declarator '(' identifier_list ')'
	;

declaration_no_const
	: declaration_specifiers_no_const ';'
	| declaration_specifiers_no_const init_declarator_list_no_const ';'
	;

declaration_specifiers_no_const
	: scalar_type
	| scalar_type declaration_specifiers_no_const

init_declarator_list_no_const
	: init_declarator_no_const
	| init_declarator_list_no_const ',' init_declarator_no_const

init_declarator_no_const
	: declarator_no_const '=' initializer
	| declarator_no_const
	;

declarator_no_const
	: IDENTIFIER
	| '(' declarator_no_const ')'
	| declarator_no_const '(' ')'
	| declarator_no_const '(' parameter_list ')'
	| declarator_no_const '(' identifier_list ')'
	;

function_definition
	: declaration_specifiers_no_const declarator_no_const declaration_list compound_statement
	| declaration_specifiers_no_const declarator_no_const compound_statement
	| VOID declarator_no_const declaration_list compound_statement
	| VOID declarator_no_const compound_statement
	;

initializer
	: '(' ')'
	| '(' initializer_list ')'
	| '(' initializer_list , ')'
	| assignment_expression_without_func
	;

initializer_list
	: designator_list '=' initializer
	| initializer
	| initializer_list ',' designator_list '=' initializer
	| initializer_list ',' initializer
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
	| paramenter_list ',' parameter_declaration
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
	| '{' statement_list '}'
	| '{' declaration_list '}'
	| '{' declaration_list statement_list '}'
	;

	'{' block_item_list '}'
	;

block_item_list
	: global_declarations statement_group
	;

statement_group
	: /*empty*/
	| statement_group statement
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

expression_statement
	: ';'
	| expression ';'
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

assignment_expression
	: logical_or_expression
	| unary_expression '=' assignment_expression
	;

assignment_expression_without_func
	: logical_or_expression_without_func
	| unary_expression_without_func '=' assignment_expression_without_func
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

unary_operator
	: '&'
	| '+'
	| '-'
	| '!'
	;




/* do we need scalar_type idetifier_list '=' expression ? */

array_declaration
	: scalar_type array_identifier_list ';'
	| scalar_type array_identifier '=' arr_content ';'
	;

array_identifier_list
	: array_identifier
	| array_identifier_list array_identifier
	;

array_identifier
	: Identifier array_range_list
	;

array_range_list
	: array_range
	| array_range_list array_range
	;

array_range
	: '[' int_constant ']'
	;

argument_list
	: argument
	| argument_list argument
	;

argument
	: scalar_type identifier_list
	| arra


function_declaration
	: scalar_type identifier '(' argument_list ')' ';'
	;

function_call
	: Identifier '('  ')'
	| Identifier '=' Identifier '(' ')'
	| Identifier '(' expr_list ')'
	| Identifier '=' Identifier '(' expr_list ')'
	;

function_definition
	: 

expr_list
	: expr
	| expr_list expr
	;

statement
	: identifier '=' expr ';'
	| array_identifier '=' expr ';'
	;

scalar_declaration
	: scalar_type identifier_list ';'
	| scalar_type identifier '=' literal_constant ';'
	| CONST scalar_type identifier_list ';'
	| CONST scalar_type identifier '=' literal_constant ';'
	;

literal_constant
	: NUMBER_INTEGER
	| NUMBER_DOUBLE
	| NUMBER_SCI
	| CHARACTER
	; 







struct_specifier
	: STRUCT IDENTIFIER
	| STRUCT IDENTIFIER '{' struct_declaration_list '}'
	| STRUCT '{' struct_declaration_list '}'
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
	;

specifier_qualifier_list
	: type_specicifer specifier_qualifier_list
	| type_specicifer

struct_declarator_list
	: declarator
	| ':' constant_expression
	| declarator ':' constant_expression
	;


	| FOR 
	| WHILE 
	| DO 
	| IF 
	| ELSE 
	| SWITCH 
	| RETURN 
	| BREAK 

%% 
int main(){
	yyparse();
	printf("No Syntax error!\n")
	return 0;
}
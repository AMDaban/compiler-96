/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

int commentDepth = 0;
int stringLength = 0;
%}

/*
 * Define names for regular expressions here.
 */

DARROW_TOKEN    =>
LE_TOKEN        <=
ASSIGN_TOKEN    <-
DIGIT           [0-9]

%x STR COMMENT BRSTRING
%%

<COMMENT>{
 /*
  *  Nested comments
  */
 
 /*
  *  Nested comment found...
  */
"(*" {
      commentDepth++;
      BEGIN(COMMENT); 
    }

 /*
  *  Start of a comment
  */
\n  {
      ++curr_lineno;
    }

 /*
  *  End of one comment
  */
"*)"  {   
        commentDepth--;
        if (commentDepth == 0) {
          BEGIN(INITIAL);
        } 
      }

 /*
  *  Error: EOF in comment
  */
<<EOF>> {
          BEGIN(INITIAL); 
          cool_yylval.error_msg = "EOF in comment";
          return(ERROR);
        }

 /*
  *  Eat up every thing else
  */
. {}

}

<INITIAL>{

 /*
  *  Start of a comment
  */
"(*" {
      commentDepth++;
      BEGIN(COMMENT); 
    }

 /*
  *  Two below rules eat up one line comments
  */
"--".*\n  {
            curr_lineno++;
          }

"--".*  {
          curr_lineno++;
        }

 /*
  *  The multiple-character operators.
  */
{DARROW_TOKEN}  {
                  return (DARROW);
                }

{LE_TOKEN}      {
                  return (LE);  
                }

{ASSIGN_TOKEN}  {
                  return (ASSIGN);
                }

 /*
  * We have to keep the line number that lexer works on
  */
\n  {
      ++curr_lineno;
    }

 /*
  * eat up white spaces
  */
[ \f\r\t\v] ;

 /*
  * single character operators or symbols
  */
[:;(=).+\-*/<,~{@}] {
                      return *yytext; 
                    }

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */

 /*
  * We have 19 keywords in cool that are listed below 
  */

 /*
  * These Keywords are case insensitive 
  */
(?i:class)  {
              return (CLASS);
            }

(?i:else) {
            return (ELSE);
          }

(?i:fi) {
          return (FI);
        }

(?i:if) {
          return (IF);
        }

(?i:in) {
          return (IN);
        }

(?i:inherits) {
                return (INHERITS);
              }

(?i:isvoid) {
              return (ISVOID);
            }

(?i:let)  {
            return (LET);
          }

(?i:loop) {
            return (LOOP);     
          }

(?i:pool) {
            return (POOL);
          }

(?i:then) {
          return (THEN);
          }

(?i:while)  {
              return (WHILE);
            }

(?i:new)  {
            return (NEW);
          }

(?i:of) {
          return (OF);
        }

(?i:not)  {
            return (NOT);
          }

(?i:case) {
            return (CASE);
          }
                 
(?i:esac) {
            return (ESAC);
          } 

 /*
  * These two Keywords(true and false) are case sensitive (must start with a lower-case letter) 
  */
t(?i:rue) {
            cool_yylval.boolean = 1;
            return (BOOL_CONST);
          }

f(?i:alse)  { 
              cool_yylval.boolean = 0;
              return (BOOL_CONST);     
            }

 /*
  * Begin of a String
  */
\"  { 
      BEGIN(STR);
    }

 /*
  * Integers
  * Simply store matched integer in the Table
  */
{DIGIT}+  {
            cool_yylval.symbol = inttable.add_int(atoi(yytext));
            return (INT_CONST);
          }

 /*
  * Identifiers 
  * Simply store matched String in the Table
  */

 /*
  * TypeIDs must start with a capital letter
  */ 
[A-Z][a-zA-Z0-9_]*  { 
                      cool_yylval.symbol = stringtable.add_string(yytext);
                      return (TYPEID);
                    }


 /*
  * ObjectIDs must start with a non-capital letter
  */
[a-z][a-zA-Z0-9_]*  { 
                      cool_yylval.symbol = stringtable.add_string(yytext);
                      return (OBJECTID);
                    }

 /*
  * Others...
  * All of the them make errors
  */

 /*
  * Unexpected *)
  */
"*)"  {
        cool_yylval.error_msg = "Unmatched *)";
        return ERROR;
      }

 /*
  * Other unexpected tokens
  */
. {
    char *buf = (char*)malloc(64);
    sprintf(buf, "%s", yytext);
    cool_yylval.error_msg = buf;
    return ERROR;
  }

}

<STR>{
 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


 /*
  * End of String
  */
  \"  { 
        // Save String in String Table
        cool_yylval.symbol = stringtable.add_string(string_buf);

        //emptying buffer
        stringLength = 0;
        string_buf[0] = '\0';

        BEGIN(INITIAL);
        return(STR_CONST);
      }

 /*
  * String contains null character
  */
(\0|\\\0) {
            cool_yylval.error_msg = "String contains null character";

            //emptying buffer
            stringLength = 0;
            string_buf[0] = '\0';

            BEGIN(BRSTRING);
            return(ERROR);
          }


 /*
  * Escaped new line
  */
\\\n  {   
        if (stringLength + 1 >= MAX_STR_CONST){
          BEGIN(BRSTRING);
          
          //emptying buffer
          stringLength = 0;
          string_buf[0] = '\0';

          cool_yylval.error_msg = "String constant too long";
          return ERROR;
        }

        curr_lineno++; 
        strcat(string_buf, "\n");
        stringLength++;
      }

 /*
  * Unescaped new line
  */
\n  {   
      curr_lineno++; 
      BEGIN(INITIAL);

      //emptying buffer
      stringLength = 0;
      string_buf[0] = '\0';

      cool_yylval.error_msg = "Unterminated string constant";
      return(ERROR);
    }

<<EOF>> {   
          BEGIN(INITIAL);
          cool_yylval.error_msg = "EOF in string constant";
          return(ERROR);
        }

\\n { 
      if (stringLength + 1 >= MAX_STR_CONST){
        BEGIN(BRSTRING);
        
        //emptying buffer
        stringLength = 0;
        string_buf[0] = '\0';

        cool_yylval.error_msg = "String constant too long";
        return ERROR;
      }

      strcat(string_buf, "\n");
      stringLength++;
    }

\\t {
      if (stringLength + 1 >= MAX_STR_CONST){
        BEGIN(BRSTRING);
        
        //emptying buffer
        stringLength = 0;
        string_buf[0] = '\0';

        cool_yylval.error_msg = "String constant too long";
        return ERROR;
      }

      stringLength++;
      strcat(string_buf, "\t");
    }

\\b {
      if (stringLength + 1 >= MAX_STR_CONST){
        BEGIN(BRSTRING);
        
        //emptying buffer
        stringLength = 0;
        string_buf[0] = '\0';

        cool_yylval.error_msg = "String constant too long";
        return ERROR;
      }

      stringLength++;
      strcat(string_buf, "\b");
    }

\\f {
      if (stringLength + 1 >= MAX_STR_CONST){
        BEGIN(BRSTRING);
        
        //emptying buffer
        stringLength = 0;
        string_buf[0] = '\0';

        cool_yylval.error_msg = "String constant too long";
        return ERROR;
      }

      stringLength++;
      strcat(string_buf, "\f");
    }

\\. {
      if (stringLength + 1 >= MAX_STR_CONST){
        BEGIN(BRSTRING);
        
        //emptying buffer
        stringLength = 0;
        string_buf[0] = '\0';

        cool_yylval.error_msg = "String constant too long";
        return ERROR;
      }

      stringLength++;
      strcat(string_buf, &strdup(yytext)[1]);
    }

. {   
    if (stringLength + 1 >= MAX_STR_CONST){
        BEGIN(BRSTRING);
        
        //emptying buffer
        stringLength = 0;
        string_buf[0] = '\0';

        cool_yylval.error_msg = "String constant too long";
        return ERROR;
    }

    strcat(string_buf, yytext);
    stringLength++;
  }

}


 /*
  * In case of brokenString eats up rest of string
  */
<BRSTRING>[^\n\"]*\"  {
                        BEGIN(INITIAL);
                      }

<BRSTRING>[^\n\"]*\n  {
                        curr_lineno++;
                        BEGIN(INITIAL);
                      }

%%

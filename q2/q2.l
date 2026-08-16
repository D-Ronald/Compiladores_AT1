/* even more like Unix wc */
%option noyywrap

%{
#include <stdio.h>
#include <string.h>

%}

%%
\+        { printf("PLUS\n"); }
\-        { printf("MINUS\n"); }
\*        { printf("TIMES\n"); }
\/        { printf("DIVIDE\n"); }
\|        { printf("ABS\n"); }
\(        { printf("LPAREN\n");}
\)        { printf("RPAREN\n");}
\%        { printf("MOD\n"); }
\^        { printf("POWER\n"); }
"<"|">"|"<="|">="|"!=" {printf("REL_OP %s\n", yytext);}
[0-9]+    { printf("NUMBER %s\n", yytext); }
[ ]       {}
\t        {}
\n        { printf("NEWLINE\n"); }
<<EOF>>     { printf("NEWLINE\n"); yyterminate(); }
.         { printf("Mystery character %s\n", yytext); }
%%

int main(int argc, char **argv)
{
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
    }

    yylex();


    return 0;
}
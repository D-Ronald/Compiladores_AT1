
%option noyywrap

%{
#include <stdio.h>
#include <string.h>

FILE *out;
%}

%%
[ ]  {}
\t  {}
\n  {}
"if"    {fprintf(out, "IF\n");}
"while" {fprintf(out, "WHILE\n");}
"eslse" {fprintf(out, "ELSE\n");}
"return" {fprintf(out, "RETURN\n");}
"//".*   {}
[a-zA-Z_]+[a-zA-Z_0-9]*  {fprintf(out, "ID %s\n", yytext);}
[0-9]+  {fprintf(out, "NUMBER %s\n", yytext);}
[0-9]+\.[0-9]+  {fprintf(out, "NUMBER %s\n", yytext);}
.  {fprintf(out, "SIMBOLO %s\n", yytext);}
%%

int main(int argc, char **argv)
{
    if (argc < 2) {
        printf("Erro: Arquivo nao passado como argumento.\n");
        return 1;
    }

    if (!(yyin = fopen(argv[1], "r"))) {
        printf("Erro: Nao foi possivel abrir o arquivo.\n");
        return 1;
    }

    out = stdout;
    yylex();

    return 0;
}
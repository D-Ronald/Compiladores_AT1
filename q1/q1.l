/* even more like Unix wc */
%option noyywrap

%{
#include <stdio.h>
#include <string.h>

int caracteres = 0;
int palavras = 0;
int linhas = 1;
int numeros_inteiros = 0;
int numeros_flutuantes = 0;
int pontuacoes = 0;
%}

%%

[a-zA-Z]+ { palavras++; caracteres += strlen(yytext); }
[0-9]+    { numeros_inteiros++; caracteres+= strlen(yytext);}
[0-9]+\.[0-9]+  { numeros_flutuantes++; caracteres+= strlen(yytext);}
[.,;:!?]  { pontuacoes++; caracteres++; }
\n        { caracteres++; linhas++; }
.         { caracteres++; }
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

    printf("Linhas:%8d\nPalavras:%8d\nCaracteres:%8d\nNumeros inteiros:%8d\nNumeros" 
    "flutuantes:%8d\nPontuações:%8d",
     linhas, palavras, caracteres, numeros_inteiros, numeros_flutuantes, pontuacoes);

    return 0;   
}
%{
 
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

 
%}
%union  {int ent;float flo;char *chain; boolean bl;}
%token  <chain>ID
%token  LIRE ECRIRE
%token  POUR  FAIRE FPOUR
%token  SI ALORS SINON FSI
%token  <ent>ENTIER <flo>REEL  <bl>BOOLEEN <chain>CHAINE
%token  INF SUP INFEGAL SUPEGAL ET OU NON DIFF EGAL DEGAL
%token  PLUS  MOINS FOIS  DIVISE  PUISSANCE
%token  PARENTHESE_OUVERANTE PARENTHESE_FERMANTE
%token  ALGO
%token  DEBUT
%token  NOM
%token  FIN

 
%type <flo>Expression
%type <chain>NOM
%type <chain>IDENTIFIANTS
%type <ent>PRGM
%type <flo>INSTRUCTION
%type <ent>CONDITION
%left PLUS  MOINS
%left FOIS  DIVISE
%left NEG
%right  PUISSANCE
 
%start S
%%
 S:  ALGO NOM DECLARATION PRGM A|FIN {YYACCEPT;}
    ;
   
  A: PRGM A
    |FIN
    ;
         
DECLARATION : TYPE IDENTIFIANTS ";"
           |TYPE IDENTIFIANTS";" DECLARATION
      ;
 
TYPE :ENTIER
      |REEL|BOOLEEN|CHAINE
      ;
       
IDENTIFIANTS :
       ID
       |ID IDENTIFIANTS
       ;
      
PRGM:
    Expression FIN    { printf("Voici Votre Resultat : %.2f \n",$1);};
  |INSTRUCTION FIN    {printf("%s",$$);}
  ;
   
INSTRUCTION :
             ECRIRE PARENTHESE_OUVERANTE ID PARENTHESE_FERMANTE  { printf("%s",$3);}
            |LIRE  PARENTHESE_OUVERANTE ID PARENTHESE_FERMANTE   { scanf("%s",&$$);}
            |ECRIRE PARENTHESE_OUVERANTE Expression PARENTHESE_FERMANTE { $$=$3; printf("%f",$$);}
            |LIRE  PARENTHESE_OUVERANTE Expression PARENTHESE_FERMANTE    { scanf("%f",&$$);}
            |ID EGAL Expression {$$=$3;}    
            |SI PARENTHESE_OUVERANTE CONDITION PARENTHESE_FERMANTE ALORS INSTRUCTION FSI                     
            |SI PARENTHESE_OUVERANTE CONDITION PARENTHESE_FERMANTE ALORS INSTRUCTION SINON INSTRUCTION FSI
            |POUR PARENTHESE_OUVERANTE CONDITION PARENTHESE_FERMANTE FAIRE INSTRUCTION FPOUR
            |Expression
            ;
   
Expression:
 
    Expression PLUS Expression  { $$=$1+$3; }
  | Expression MOINS Expression { $$=$1-$3; }
  | Expression FOIS Expression  { $$=$1*$3; }
  | Expression DIVISE Expression  { $$=$1/$3; }
  | MOINS Expression %prec NEG  { $$=-$2; }
  | Expression PUISSANCE Expression { $$=pow($1,$3); }
  | PARENTHESE_OUVERANTE Expression PARENTHESE_FERMANTE  { $$=$2; }
  | REEL  {$$=$1;}
  | ENTIER {$$=$1;}
;
   
CONDITION :
  Expression INF Expression           {$$=0; if($1<$3) $$=1;}
  |Expression INFEGAL  Expression     {$$=0; if($1<=$3) $$=1;}
  |Expression SUP Expression          {$$=0; if($1>$3) $$=1;}
  |Expression SUPEGAL Expression      {$$=0; if($1>=$3) $$=1;}
  |Expression DEGAL Expression        {$$=0; if($1==$3) $$=1;}
  |Expression DIFF Expression         {$$=0; if($1!=$3) $$=1;}
  |Expression ET Expression           {$$=0; if($1&&$3) $$=1;}
  |Expression OU Expression           {$$=0; if($1||$3) $$=1;}
  |NON Expression                     {$$=0; if(!$2) $$=1;}
  ;
 
%%
 
int yyerror(char *s) {
  printf("%s\n",s);
}


int main(void) {
  yyparse();
}
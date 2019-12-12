
%{
 
#include "TP.tab.h"
#include <stdlib.h>
#include <stdlib.h>
#include <math.h>

%}
 
blancs    [ \t]+
chiffre   [0-9]
entier    {chiffre}+
reel    {entier}("."{entier})?({entier}*)
let       [a-zA-Z]
id      {let}({chiffre}|{let})*
 
%%
 
{blancs}  {  }
{entier}  {  yylval.ent=atof(yytext); return(ENTIER); }
{reel}    {  yylval.flo=atof(yytext);  return(REEL);    }
"+"       return(PLUS);
"-"       return(MOINS);
"*"       return(FOIS);
"/"       return(DIVISE);
"<"       return(INF);
">"       return(SUP);
"<="      return(INFEGAL);
">="      return(SUPEGAL);
"et"      return(ET);
"ou"      return(OU);
"non"     return(NON);
"!="      return(DIFF);
"="       return(EGAL);
"=="      return(DEGAL);
"^"       return(PUISSANCE);
"("       return(PARENTHESE_OUVERANTE);
")"       return(PARENTHESE_FERMANTE);
"\n"      return(FIN);
"boleen"  return(BOOLEEN);
"Algo"    return (ALGO);
"Debut"    return(DEBUT)
"si"      return(SI);
"alors"   return(ALORS);
"sinon"   return(SINON);
"fsi"     return(FSI);
"tant que" return(TANTQUE);
"fait"     return(FAIR);
"repeter" return(REPETER);
"jusqu'a" return(JUSQU'A);
"fintanque" return"FINTANTUE"
"lire"    return(LIRE);
"ecrire"  return(ECRIRE);
"pour"    return(POUR);
"faire"   return(FAIRE);
"finpour"   return(FPOUR);
{id}     {yylval.chain=strdup(yytext); return(ID);}
%%

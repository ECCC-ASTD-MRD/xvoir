#include <stdio.h>
#include <string.h>

int  strfind();

int strfind(SousChaine, Chaine)
char *SousChaine, *Chaine;
{
int i,j, LongueurChaine, LongueurSousChaine, PositionTrouvee;

PositionTrouvee = -1;
LongueurChaine = strlen (Chaine);
LongueurSousChaine = strlen (SousChaine);

if (LongueurChaine < LongueurSousChaine)
   return(PositionTrouvee);

i=0;
while (i < LongueurChaine && PositionTrouvee == -1)
      {
      if (SousChaine[0] == Chaine[i])
	 {
	 j = i + LongueurSousChaine - 1;

	 if (j > LongueurChaine)
	    return(PositionTrouvee);

	 while (j > i && SousChaine[j-i] == Chaine[j])
	       j--;

         if (j==i)
	    PositionTrouvee = i;
         }
      i++;
      }
return(PositionTrouvee); 
}



/**
void LireLigne(FichierEntree, Ligne)
FILE *FichierEntree;
char Ligne[];
{
   int i=0;

   strcpy(Ligne, "");
   if (feof(FichierEntree) != 0)
          return;

   Ligne[0] = fgetc(FichierEntree);
   while (feof(FichierEntree) == 0 && Ligne[i] != '\n')
      {
          i++;
	  Ligne[i] = fgetc(FichierEntree);
	  }
   Ligne[i] = '\0';
   }
**/

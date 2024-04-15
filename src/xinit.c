/* RMNLIB - Library of useful routines for C and FORTRAN programming
 * Copyright (C) 1975-2001  Division de Recherche en Prevision Numerique
 *                          Environnement Canada
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation,
 * version 2.1 of the License.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

/**
 ** fichier xinit.c
 **
 ** Auteur: Yves Chartier (RPN)
 **
 ** Creation: Avril 1990
 ** Dernieres modifications: 28 mai 1990
 **/

#include "xinit.h"
#include <ctype.h>
#include <rmn/rpnmacros.h>

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <limits.h>

/* #define DEFAULT_RESOURCE_DIR "/usr/local/env/armnlib/data" */
#define DEFAULT_RESOURCE_DIR ""
#define INITIALISATION_COMPLETEE 101

/* Ajouter quelques valeurs de défaut pour les ressources de Motif */
static String RessourcesDeDefaut[] = {
   /* le titre en haut de la fenêtre */
   "*title: XVoir",
   "xvoirSelecteurEnr*popup_popup*title: XVoir - selecteur",
   "xvoirRecordSelector*popup_popup*title: XVoir - selector",

   /* le nombre de lignes visibles */
   "xvoirSelecteurEnr*listeRecords.visibleItemCount: 20",
   "xvoirRecordSelector*recordList.visibleItemCount: 20",

   /* la police de caractères */
   //   "*fontList:   6x10",
   //"*fontList:   XtDefaultFont",
   NULL, };
SuperWidgetStruct SuperWidget = { NULL, NULL };
Widget   xglTopLevel, xglBox, xglCoreWidget;
static char *defaultResourceDir = NULL;
  
/**
************************************************************
************************************************************
**/

int Xinit(char nomApplication[])
{
   Arg args[10];
   static char **argv;  
   static char *classeApplication;  
   static int   statutInitialisation;
   char *envvar;
   char *armlibdata;
   int i; 
   int argc = 1;

   if (SuperWidget.topLevel != NULL)
      return 1;
   else
      {
      armlibdata = getenv("ARMNLIB_DATA");
      if (armlibdata == NULL)
      {
	 printf("La variable d'environnement ARMNLIB_DATA n'est pas définie... On utilisera les valeurs de défaut.\n");
      }
      else
      {
         /* ajouter la variable XAPPLRESDIR=armlibdata à l'environnement */
         static char xapplresdir[PATH_MAX+20];
         strcat( strcpy(xapplresdir, "XAPPLRESDIR="), armlibdata );
         
         envvar = (char *) xapplresdir;
         putenv(envvar);
      }

      argv = (char **) calloc(1, sizeof(char *));
      argv[0] = (char *) calloc(strlen(nomApplication)+1, sizeof(char));
      strcpy(argv[0], nomApplication);
      
      classeApplication = (char *) calloc(strlen(nomApplication)+1, sizeof(char));
      strcpy(classeApplication, nomApplication);
      
      classeApplication[0] = (char)(toupper(classeApplication[0]));
      classeApplication[1] = (char)(toupper(classeApplication[1]));
      
      i = 0;
      SuperWidget.topLevel = XtAppInitialize(&(SuperWidget.contexte), 
					     classeApplication, NULL, 0, 
					     &argc, argv, RessourcesDeDefaut, 
					     args, i);
      free(argv[0]);
      free(argv);
      free(classeApplication);
      statutInitialisation = INITIALISATION_COMPLETEE;
      return 1;
      }
   }

/**
************************************************************
************************************************************
**/

int f77name(xinit)(char nomApplication[], F2Cl  flenNomApplication)
{
   char copieNomApplication[256];
   int  lenNomApplication=flenNomApplication;
   
   strncpy(copieNomApplication, nomApplication, lenNomApplication);
   copieNomApplication[lenNomApplication] = '\0';

   return(Xinit(copieNomApplication));
}


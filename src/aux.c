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

/***********************************************************
 **
 **  look.c: permet de charger la fonte desiree.
 **           retourne la structure XFontStruct cree.
 **
 **********************************************************/

#include <stdio.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>

#include <X11/Xlib.h>
#include <X11/Xutil.h>

#include <Xm/Xm.h>

#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>

static char fg_name[] = "White",
            bg_name[] = "SlateBlue",
            bc_name[] = "DarkSlateBlue";


/*****************************************************
 **
 **  chargerLaFonte:
 **
 *****************************************************/

XFontStruct *chargerLaFonte(Display *display, char fontName[])
{ 
  XFontStruct *fontStruct;
 
  fontStruct = XLoadQueryFont(display, fontName);

  if (fontStruct == NULL)
     fprintf(stderr, "Cette fonte n'est pas disponible\n");
  
  return(fontStruct);
}


/***************************************************************
 **
 **  InitColor: Seter les couleurs des foreground, background 
 **             et borderShadow.
 **
 ***************************************************************/


/*********************************************************
 *
 *  auxXmToS: transformer XmString en string.
 *
 *********************************************************/

void auxXmToS(XmString xm, char **string)
{ 
  XmStringGetLtoR(xm, XmSTRING_DEFAULT_CHARSET, string);
}


/*********************************************************
 *
 *  auxSToXm: transformer string en XmString.
 *
 *********************************************************/

void auxSToXm(XmString *xm, char *string)

{
  *xm= XmStringCreateLtoR(string, XmSTRING_DEFAULT_CHARSET);
}

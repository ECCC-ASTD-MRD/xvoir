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

Colormap cmap;


/*****************************************************
 **
 **  chargerLaFonte:
 **
 *****************************************************/

XFontStruct *chargerLaFonte(display, fontName)
Display *display;
char fontName[];
{ XFontStruct *fontStruct;
 
  fontStruct = XLoadQueryFont(display, fontName);

  if (fontStruct == 0)
     fprintf(stderr, "Cette fonte n'est pas disponible\n");
  else
     return(fontStruct);

}




/***************************************************************
 **
 **  InitColor: Seter les couleurs des foreground, background 
 **             et borderShadow.
 **
 ***************************************************************/

void InitColor(display, foreground, background, bordercolor)
Display *display;
int *foreground, *background, *bordercolor;
{ 
  XColor exact_def;
  int depth, screen;


screen = DefaultScreen(display);
depth  = DefaultDepth(display, screen);
cmap   = DefaultColormap(display, screen);

/*
if (depth > 1)
   {
     ** foreground **
     if (!XParseColor(display, cmap, fg_name, &exact_def))
        printf("erreur couleur foreground\n"); 
     if (!XAllocColor(display, cmap, &exact_def))
        printf("erreur allocaColor  foreground\n"); 
     *foreground = exact_def.pixel;

     ** background **
     if (!XParseColor(display, cmap, bg_name, &exact_def))
        printf("erreur couleur background\n"); 
     if (!XAllocColor(display, cmap, &exact_def))
        printf("erreur allocaColor  background\n"); 
     *background = exact_def.pixel;

     ** bordercolor **
     if (!XParseColor(display, cmap, bc_name, &exact_def))
        printf("erreur couleur bordercolor\n"); 
     if (!XAllocColor(display, cmap, &exact_def))
        printf("erreur allocaColor  bordercolor\n"); 
     *bordercolor = exact_def.pixel;
   }
else
  printf("depth de 1\n");
*/


}



/*********************************************************
 *
 *  XmToS: transformer XmString en string.
 *
 *********************************************************/

void XmToS(xm, string)
XmString xm;
char **string;
{ int i;

  XmStringGetLtoR(xm, XmSTRING_DEFAULT_CHARSET, string);
}



/*********************************************************
 *
 *  SToXm: transformer string en XmString.
 *
 *********************************************************/

void SToXm(xm, string)
XmString *xm;
char *string;
{
  *xm= XmStringCreateLtoR(string, XmSTRING_DEFAULT_CHARSET);
}

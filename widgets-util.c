#include <xinit.h>
#include <c_wgl.h>
#include <Xm/Xm.h>

extern SuperWidgetStruct SuperWidget;

InitPixelsCouleursDeBase(indCouleurs)
Pixel indCouleurs[];
{
   Display *disp;
   Colormap cmap;
   XColor exact, couleurs[16];
   
   disp = XtDisplay(SuperWidget.topLevel);
   cmap = DefaultColormap(disp, DefaultScreen(disp));
   
   XAllocNamedColor(disp, cmap, "black",   &exact, &couleurs[NOIR]);
   indCouleurs[NOIR] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "red",     &exact, &couleurs[ROUGE]);
   indCouleurs[ROUGE] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "darkgreen",   &exact, &couleurs[VERT]);
   indCouleurs[VERT] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "yellow",  &exact, &couleurs[JAUNE]);
   indCouleurs[JAUNE] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "blue",    &exact, &couleurs[BLEU]);
   indCouleurs[BLEU] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "magenta", &exact, &couleurs[MAGNTA]);
   indCouleurs[MAGNTA] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "cyan",    &exact, &couleurs[CYAN]);
   indCouleurs[CYAN] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "white",   &exact, &couleurs[BLANC]);
   indCouleurs[BLANC] = exact.pixel;
   
   XAllocNamedColor(disp, cmap, "gray",   &exact, &couleurs[BLANC]);
   indCouleurs[8] = exact.pixel;
   }

InvertWidget(w)
Widget w;
{
   int i;
   Pixel back, fore;
   Arg args[2];


   i = 0;
   XtSetArg(args[i], XmNbackground, &back); i++;
   XtSetArg(args[i], XmNforeground, &fore); i++;
   XtGetValues(w, args, i);

   i = 0;
   XtSetArg(args[i], XmNbackground, fore); i++;
   XtSetArg(args[i], XmNforeground, back); i++;
   XtSetValues(w, args, i);

   FlusherTousLesEvenements();
   }



AjusterPositionForme(w, wp)
Widget w, wp;
{
   Position i,x,y,wWidth,wHeight, wpWidth, wpHeight;
   Position displayWidth, displayHeight;
   XWindowAttributes xwat;

   Arg args[4];

   displayHeight = DisplayHeight(XtDisplay(w), DefaultScreen(XtDisplay(w)));
   displayWidth  = DisplayWidth(XtDisplay(w), DefaultScreen(XtDisplay(w)));
   
   XGetWindowAttributes(XtDisplay(w), XtWindow(wp), &xwat);

   x = xwat.x;
   y = xwat.y;

   i = 0;
   XtSetArg(args[i], XmNwidth, &wpWidth); i++;
   XtSetArg(args[i], XmNheight,&wpHeight); i++;
   XtGetValues(wp, args, i);

   i = 0;
   XtSetArg(args[i], XmNwidth, &wWidth); i++;
   XtSetArg(args[i], XmNheight,&wHeight); i++;
   XtGetValues(w, args, i);

   x += (int)(wpWidth * 0.5);
   y += (int)(wpHeight * 0.5);

   x -= (int)(wWidth * 0.5);
   y -= (int)(wHeight * 0.5);

   if (x < 0)
      x = 0;

   if (y < 0)
      y = 0;

   if ((x + wWidth) > displayWidth)
      x = displayWidth - wWidth;

   if ((y + wHeight) > displayHeight)
      y = displayHeight - wHeight;

   i = 0;
   XtSetArg(args[i], XmNx, x); i++;
   XtSetArg(args[i], XmNy, y); i++;
   XtSetValues(w, args, i);
   }

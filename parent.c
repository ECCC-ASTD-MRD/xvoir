#include <stdio.h>
#include <string.h>

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>

#include <xinit.h>

extern SuperWidgetStruct SuperWidget;

Widget TrouverWidgetParent(eventWindow)
Window  eventWindow;
{
   Display *display;
   Widget   widgetCourant, widgetParent;
   
   display = XtDisplay(SuperWidget.topLevel);
   widgetCourant = XtWindowToWidget(display, eventWindow);

   if (widgetCourant == NULL)
      return NULL;
   
   widgetParent = XtParent(widgetCourant);
   while (widgetParent != NULL)
      {
      widgetCourant = widgetParent;
      widgetParent = XtParent(widgetCourant);
      };
   
   return widgetCourant;
   }

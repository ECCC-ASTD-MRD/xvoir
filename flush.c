#include <rec.h>
#include <xinit.h>

extern SuperWidgetStruct SuperWidget;

FlusherTousLesEvenements()
{
   XEvent theEvent;
   
   while (XtAppPending(SuperWidget.contexte))
      {
      XtAppNextEvent(SuperWidget.contexte, &(theEvent));
      XtDispatchEvent(&(theEvent));
      }

   XFlush(XtDisplay(SuperWidget.topLevel));
/**   XSync(XtDisplay(SuperWidget.topLevel), False); **/
   }

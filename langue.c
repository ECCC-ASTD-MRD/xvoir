#include <rpnmacros.h>
#include <xinit.h>

int f77name(getulng)()
{
   return c_getulng();
   }


int c_getulng()
{
   char *langue;
   static int langueInitialisee = 0;
   static int langueUsager;


   if (langueInitialisee == 0)
      {
      langue = (char *)getenv("CMCLNG");
      if (langue != NULL)
	 {
	 if (0 == strcmp(langue, "english"))
	    langueUsager = 1;
	 else
	    langueUsager = 0;
	 }
      else
	 {
	 langueUsager = 0;
	 }
      
      langueInitialisee = 1;
      }
   
   return langueUsager;
   
   }


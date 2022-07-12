set(FILES_C aux.c flush.c langue.c parent.c strutil.c widgets-util.c xinit.c xrecsel.c)
set(FILES_F90 get_nbrecs_actifs.f90 xfsl-xvoir-2000.f90)

add_definitions(-DX_WGL)
set(EXTRA_LIBRARIES "-lXm -lXt -lSM -lICE -lXext -lX11 -lz -lm -ldl -ljpeg")

add_library (_${NAME} ${FILES_C} ${FILES_F90})
target_link_libraries(_${NAME} rmn ${EXTRA_LIBRARIES})
#CFLAGS = -I/opt/xm/include -I/usr/X11R6/include -I../include -DX_WGL  

add_executable (${NAME} xvoir.f90)
target_link_libraries(${NAME} _${NAME} rmn ${EXTRA_LIBRARIES})

install(TARGETS ${NAME})

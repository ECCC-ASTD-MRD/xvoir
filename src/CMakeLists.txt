set(FILES_C aux.c flush.c langue.c parent.c strutil.c widgets-util.c xinit.c xrecsel.c)
set(FILES_F90 get_nbrecs_actifs.f90 xfsl-xvoir-2000.f90)

set(EXTRA_LIBRARIES "-lXm -lXt -lX11")
include(ec_shared_lib)
 
add_executable(${NAME} ${FILES_C} ${FILES_F90} xvoir.f90)
target_link_libraries(${NAME} rmn ${EXTRA_LIBRARIES})
install(TARGETS ${NAME})

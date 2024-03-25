integer function xfslvoir2000(nomfich, iun, ttlrecs, winind, typesel, styleflag)
  implicit none
  integer ttlrecs,ntmrecs
  character(len=128) nomfich
  integer iun, winind, typesel
  logical styleflag
  
#include "xfsl-voir.cdk"
  
  character(len=4) nomvar
  character(len=2) typvar
  character(len=1)  grtyp, cdatyp
  character(len=12) etiket
  character(len=158)  titre
  
  integer key, date0, deet, npas, ni, nj, nk, nbits, datyp 
  integer ip1, ip2, ip3, swa, lng, dltf, ubc
  integer ig1, ig2, ig3, ig4, extra1, extra2, extra3
  integer fstinf, fstprm, fstsui, fstrwd
  integer fnom, fstfrm, res
  integer xselouv, xseloup, xselins, xselouf
  real xg1, xg2, xg3, xg4
  integer yyyymmdd,hhmmssss
  
  integer ier
  integer kind
  real p
  character(len=12) string
  integer i, j, inf

  integer, dimension (:), allocatable :: reclist
  
  if (ttlrecs.gt.0) then
     allocate (reclist(ttlrecs))
  endif
  
  nbdes = 19
  call initidv(idents, maxdes)
  call inittabv(tableau, table, ligne)
  write(titre, 5) nomfich
  
  res = xseloup(titre, ttlrecs, idents, nbdes, winind, typesel)
  
  if (ttlrecs.eq.0) then
     res = xselins(tableau,table,ttlrecs)
     goto 100
  endif
  
  i = 0
  ier = fstrwd(iun)
  key = fstinf(iun, ni, nj, nk,  -1, ' ', -1, -1, -1, ' ', ' ')
  do while (key.ge.0)
    i = i+1
    
    inf = fstprm(key, date0, deet, npas, ni, nj, nk, nbits,datyp, ip1, ip2, ip3, typvar, & 
        nomvar, etiket, grtyp, ig1, ig2, ig3, ig4, swa, lng, dltf, ubc, extra1, extra2, extra3)
    
    call get_cdatyp(cdatyp, datyp)
    call newdate(date0,yyyymmdd,hhmmssss,-3)
    hhmmssss = hhmmssss / 100
    
    if (.not.styleflag) then
      write(tableau(mod(i-1,64)), 10) NOMVAR, TYPVAR, IP1, IP2, IP3, NI, NJ, NK, ETIKET, &
             yyyymmdd,hhmmssss, deet, npas, grtyp, ig1, ig2, ig3, ig4, cdatyp, nbits
    else
      call convip_plus( ip1, p, kind, -1, string, .true.)
      if (grtyp.ne.'Z'.and.grtyp.ne.'Y') then
          call cigaxg(grtyp,xg1,xg2,xg3,xg4,ig1,ig2,ig3,ig4)
      else
          xg1 = ig1
          xg2 = ig2
          xg3 = ig3
          xg4 = ig4
      endif     
      if (grtyp.ne.'Z'.and.grtyp.ne.'Y') then
          write(tableau(mod(i-1,64)), 11) NOMVAR,TYPVAR,adjustr(string),IP2,IP3,NI, NJ, NK, ETIKET, &
            yyyymmdd,hhmmssss, deet, npas,grtyp, xg1, xg2, xg3, xg4, cdatyp, nbits
      else
          write(tableau(mod(i-1,64)), 12) NOMVAR,TYPVAR, adjustr(string),IP2,IP3,NI, NJ, NK, ETIKET, &
            yyyymmdd,hhmmssss, deet, npas,grtyp, ig1, ig2, ig3, ig4, cdatyp, nbits
      endif
    endif
    
    reclist(i) = key
    
    if (ttlrecs.le.1) then
      res = xselins(tableau,table,ttlrecs)
    endif
    
    ntmrecs = mod(i,64)
    if (ntmrecs.eq.0) then
      ntmrecs = 64
    endif
    
    if (0.eq.mod(i,64).or.i.eq.ttlrecs) then
      res = xselins(tableau,table,ntmrecs)
    endif
!   
!   goto 50
! 100 continue
    key = fstsui(iun, ni, nj, nk)
  enddo
100  res = xselouf(table, ntmrecs)
  xfslvoir2000 = winind
  
2 format(40a)
4 format(3i16)
5 format(128a)
6 format(40a)
10 FORMAT(A4, 1X, A2, 1X, I12, 1X, I12, 1X, I12, 1X, I6, 1X, I6, 1X, I6, 1X, A12, 1X, i8.8,1X,i6.6, 1X, i5, 1X, i7, 1X, a1, 1X, i9,   1X, i9,   1X, i9,   1X, i9,   1X, a1,i2.2)
11 FORMAT(A4, 1X, A2, 1X, a12, 1X, i12, 1X, I12, 1X, I6, 1X, I6, 1X, I6, 1X, A12, 1X, i8.8,1X,i6.6, 1X, i5, 1X, i7, 1X, a1, 1X, g9.3, 1X, g9.3, 1X, g9.3, 1X, g9.3, 1X, a1,i2.2)
12 FORMAT(A4, 1X, A2, 1X, a12, 1X, i12, 1X, I12, 1X, I6, 1X, I6, 1X, I6, 1X, A12, 1X, i8.8,1X,i6.6, 1X, i5, 1X, i7, 1X, a1, 1X, i9,   1X, i9,   1X, i9,   1X, i9,   1X, a1,i2.2)
  
  return
end function xfslvoir2000


!c     ****************************************************************
!c     **                                                            **
!c     ****************************************************************

integer function xfslferv(winind)
  implicit none
  integer winind
  
#include "xfsl-voir.cdk"
  
  integer xselfer
  integer i, inf, res
  
  xfslferv = xselfer(winind)
  
  
  return
end function xfslferv

!     ****************************************************************
!     **                                                            **
!     ****************************************************************

integer function xfslactv(slkeys, nslkeys, winind)
  implicit none
  integer nslkeys
  integer slkeys(nslkeys), winind
  
#include "xfsl-voir.cdk"
  
  integer xselact
  integer i, inf, res
  
  xfslactv = xselact(slkeys, nslkeys, winind)
  
!   do 200 i=1, nslkeys
!      slkeys(i) = recliste(slkeys(i)-1)
! 200  continue
!      
     
     return
   end function xfslactv
   
!   c     ****************************************************************
!   c     **                                                            **
!   c     ****************************************************************
   
! NOMV TV ----IP1----- ----IP2----- ----IP3----- --NI-- --NJ-- --NK-- -ETIQUETTE-  YYYYMMDD HHMMSS DEET  -NPAS-  G --IG1--  --IG2--  --IG3--  --IG4--  DTY
! 1234 12 123456789ABC 123456789ABC 123456789ABC 123456 123456 123456 123456789abc 12345678 123456 12345 1234567 1 12345678 12345678 12345678 12345678 123
   
   subroutine initidv(idents)
     character(len=16) idents(*)
     
     integer i, j, ulng
     integer  getulng
     external getulng
     
     idents(1) =  'NOMV'
     idents(2)  = 'TV'
     idents(3)  = '----IP1-----'
     idents(4)  = '----IP2-----'
     idents(5)  = '----IP3-----'
     idents(6)  = '--NI--'
     idents(7)  = '--NJ--'
     idents(8)  = '--NK--'
     idents(9)  = '---ETIKET---'
     idents(10) = 'YYYYMMDD'
     idents(11) = 'HHMMSS'
     idents(12) = '-DEET-'
     idents(13) = '-NPAS--'
     idents(14) = 'G'
     idents(15) = '---IG1---'
     idents(16) = '---IG2---'
     idents(17) = '---IG3---'
     idents(18) = '---IG4---'
     idents(19) = 'DTY'
     
     return
   end subroutine initidv

   subroutine inittabv(tableau, table, len)
     character(len=158) tableau(*)
     integer table(3, *)
     integer len
     integer sumlen
     integer i
     
     integer reclen(20)
     data reclen /5,3,13,13,13,7,7,7,13,9,7,6,8,2,10,10,10,10,3,0/
     
     
     sumlen       = 0
     do i=1,20
        table(1,i)   = reclen(i)
        table(2,i)   = len
        table(3,i)   = sumlen
        sumlen       = sumlen + table(1,i)
     enddo
     
     return 
   end subroutine inittabv
   
   
!dompe

! 50 if (key.lt.0) goto 100
!   i = i + 1
!   
!   if (key.lt.0) goto 100
!   inf = fstprm(key, date0, deet, npas, ni, nj, nk, nbits,datyp, ip1, ip2, ip3, typvar, &
!        nomvar, etiket, grtyp, ig1, ig2, ig3, ig4, swa, lng, dltf, ubc, extra1, extra2, extra3)
!   
!   if (datyp.eq.0) then
!      cdatyp = 'X'
!   else
!      if (datyp.eq.1) then
!         cdatyp = 'R'
!      else
!         if (datyp.eq.2) then
!            cdatyp = 'I'
!         else
!            cdatyp = 'C'
!         endif
!      endif
!   endif
!   
!   if (.not.styleflag) then
!      write(tableau(mod(i-1,64)), 10) NOMVAR, TYPVAR, IP1, IP2, IP3,NI, NJ, NK, ETIKET, &
!           DATE0, deet, npas,grtyp, ig1, ig2, ig3, ig4, cdatyp, nbits
!   else
!      if (grtyp.ne.'Z'.and.grtyp.ne.'Y') then
!         call cigaxg(grtyp,xg1,xg2,xg3,xg4,ig1,ig2,ig3,ig4)
!      else
!         xg1 = ig1
!         xg2 = ig2
!         xg3 = ig3
!         xg4 = ig4
!      endif
!      call newdate(date0,yyyymmdd,hhmmssss,-3)
!      hhmmssss = hhmmssss / 100
!      call convip_plus( ip1, p, kind, -1, string, .true.)
!      write(tableau(mod(i-1,64)), 11) NOMVAR,TYPVAR,string,IP2,IP3,NI, NJ, NK, ETIKET, &
!           yyyymmdd,hhmmssss, deet, npas,grtyp, xg1, xg2, xg3, xg4, cdatyp, nbits
!   endif
!   
!   reclist(i) = key
!   

  subroutine get_cdatyp(cdatyp, datyp)
  character(len=1) cdatyp
  integer datyp
  
    if (datyp.eq.0) then
      cdatyp = 'X'
    else if (datyp.eq.1) then
        cdatyp = 'R'
    else if (datyp.eq.2) then
        cdatyp = 'I'
    else if (datyp.eq.4) then
        cdatyp = 'S'
    else if (datyp.eq.5) then
        cdatyp='E'
    else if (datyp.eq.134) then
        cdatyp='f'
    else if (datyp.eq.130) then
        cdatyp='i'
    else if (datyp.eq.132) then
        cdatyp='s'
    else if (datyp.eq.133) then
        cdatyp='e'
    else
        cdatyp = 'C'
    endif

  return
  end subroutine get_cdatyp


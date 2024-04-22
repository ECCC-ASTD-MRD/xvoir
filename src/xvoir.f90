!/* RMNLIB - Library of useful routines for C and FORTRAN programming
! * Copyright (C) 1975-2001  Division de Recherche en Prevision Numerique
! *                          Environnement Canada
! *
! * This library is free software; you can redistribute it and/or
! * modify it under the terms of the GNU Lesser General Public
! * License as published by the Free Software Foundation,
! * version 2.1 of the License.
! *
! * This library is distributed in the hope that it will be useful,
! * but WITHOUT ANY WARRANTY; without even the implied warranty of
! * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
! * Lesser General Public License for more details.
! *
! * You should have received a copy of the GNU Lesser General Public
! * License along with this library; if not, write to the
! * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
! * Boston, MA 02111-1307, USA.
! */
program xvoir
      use app
      use rmn_fst24
      IMPLICIT NONE

      integer maxrecs
      parameter (MAXRECS= 24576)
      integer liste(24576)
      
      type(fst_file), dimension(41) :: sources
      logical        :: success

      INTEGER BUF(1)
      INTEGER IPTAB
      REAL    ASPRAT

      character(len=4) nomvar
      character(len=2) typvar 
      character(len=1) grtyp,cdatyp
      character(len=12) etiket
      character(len=158) titre
      
      INTEGER KEY, DATE0, DEET, NPAS, NI, NJ, NK, NBITS, DATYP 
      INTEGER IP1, IP2, IP3, SWA, LNG, DLTF, UBC
      INTEGER IG1, IG2, IG3, IG4, EXTRA1, EXTRA2, EXTRA3
      INTEGER FSTOUV, FSTINF, fstinl, FSTLUK, FSTPRM, FSTSUI 
      INTEGER FNOM, FSTFRM, RES, nbrecs, niun
      integer selrec
      integer xconouv, xinit
      integer xfslvoir2000, xfslactv, xselopt, xselup
      integer xconact, iargc

      INTEGER IER
      INTEGER I, J, INF
      
      character(len=16) option, valeur
      character(len=128)   nomfich
      integer        recs(MAXRECS)
      integer        indsel, iun

      real pi, pj, dgrw, d60
      
      integer nbdes
      logical styleflag
      
      character(len=16)   CLE(41)
      character(len=128) DEF(41), VAL(41)
! Vérifier la pertinence, car xvoir ne semble pas pouvoir traiter plusieurs fichiers
      integer lnkdiun(40)
!
      DATA CLE/40*'iment.', 'style'/
      DATA DEF/40*'SCRAP', 'OLDSTYLE'/
      DATA VAL/40*'SCRAP', 'NEWSTYLE'/
!
      DATA lnkdiun / 1, 11, 12, 13, 14, 15, 16, 17, 18, 19, &
                   20, 21, 22, 23, 24, 25, 26, 27, 28, 29, &
                   30, 31, 32, 33, 34, 35, 36, 37, 38, 39, &
                   40, 41, 42, 43, 44, 45, 46, 47, 48, 49 /
      
      ier = xinit('xvoir')
      nomfich = 'xvoir'

      CALL CCARD(CLE,DEF,VAL,41,-1)

      niun = 1
 33   if (val(niun).ne.'SCRAP') then
         niun = niun +1
         goto 33
      endif
         
      if (val(41).eq.'OLDSTYLE') then
         styleflag = .true.
      else
         styleflag = .false.
      endif

      niun = niun -1
      do i=1, niun
         ! REMOTE?
         success = sources(i)%open(trim(val(i)),'STD+R/O')
         if (.not. success) then
            call app_log(APP_ERROR,'Probleme d''ouverture avec le fichier '//trim(val(i)))                  
            app_status=app_end(-1)
            call qqexit(app_status)
         endif
      enddo

      if (.not. fst24_link(sources(1:niun))) then
         call app_log(APP_ERROR, 'Unable to link source files')
      endif
      
      nbrecs = sources(1)%get_num_records()
         
      option = 'bouton_fermer'
      valeur = 'oui'
      ier = xselopt(lnkdiun(1), option, valeur)
      ier = xfslvoir2000(nomfich, sources(1), nbrecs, 1, 2,styleflag)
 1000 inf = xfslactv(recs, nbrecs, 1)
      ier = xselup(1)

!      do 100 i=1,nbrecs
! 100     print *, i, recs(i)

 2    format(72a)
 4    format(3i16)
 5    format('Fichier: ', 100a)
 6    format(72a)
      ! fermer le fichier et terminer
      success = sources(i)%close()

      STOP
      END
!     ****************************************************************
!     **                                                            **
!     ****************************************************************


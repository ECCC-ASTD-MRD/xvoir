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
      IMPLICIT NONE

      integer maxrecs
      parameter (MAXRECS= 24576)
      integer liste(24576)
      
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
      INTEGER FNOM, FSTFRM, RES, nrecs, nbrecs, niun
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
      do 34 i=1, niun
         IER = FNOM(lnkdiun(i),val(i),'RND+OLD+R/O',0)
         if (ier.lt. 0) then
            print *, '***********************************************'
            print *, '* Probleme d''ouverture avec le fichier ',val(i)
            print *, '************************************************'
            stop
         endif
 34   continue

      nbrecs = 0
      nrecs = 0
      do 35 i=1,niun
         ier = FSTOUV(lnkdiun(i), 'RND')
         if (ier.lt.0) then
            print *, '**********************************************'
            print *, '* Le fichier #',val(i), 'n''est pas standard random'
            print *, '**********************************************'
            stop
         endif
         call get_nbrecs_actifs(nrecs, lnkdiun(i))

      nbrecs = nbrecs + nrecs
 35   continue
         
      call fstlnk(lnkdiun, niun)   

      iun = lnkdiun(1)
      option = 'bouton_fermer'
      valeur = 'oui'
      ier = xselopt(iun, option, valeur)
      ier = xfslvoir2000(nomfich, iun, nbrecs, 1, 2,styleflag)
 1000 inf = xfslactv(recs, nbrecs, 1)
      ier = xselup(1)

!      do 100 i=1,nbrecs
! 100     print *, i, recs(i)

 2    format(72a)
 4    format(3i16)
 5    format('Fichier: ', 100a)
 6    format(72a)
      IER = FSTFRM(1)

      STOP
      END
!     ****************************************************************
!     **                                                            **
!     ****************************************************************


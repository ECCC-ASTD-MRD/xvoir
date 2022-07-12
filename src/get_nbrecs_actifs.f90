      subroutine get_nbrecs_actifs(nbrecs, iun)
      implicit none
      integer nbrecs, iun, key, fstinf, fstsui, ni,nj,nk
      
      nbrecs = 0 
      key = fstinf(iun, ni, nj, nk,  -1, ' ', -1, -1, -1, ' ', ' ')
      do while (key >= 0)
        nbrecs = nbrecs+1
        key = fstsui(iun,ni,nj,nk)
      end do

      
      return
      end subroutine get_nbrecs_actifs

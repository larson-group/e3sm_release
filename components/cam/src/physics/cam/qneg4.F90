
subroutine qneg4 (subnam  ,lchnk   ,ncol    ,ztodt   ,        &
                  qbot    ,srfrpdel,shflx   ,lhflx   ,qflx   ,&
                  lat     ,lon     ,                          &
                  chunk_smry, l_old_qneg4_messages            )
!----------------------------------------------------------------------- 
! 
! Purpose: 
! Check if moisture flux into the ground is exceeding the total
! moisture content of the lowest model layer (creating negative moisture
! values).  If so, then subtract the excess from the moisture and
! latent heat fluxes and add it to the sensible heat flux.
! 
! Method: 
! <Describe the algorithm(s) used in the routine.> 
! <Also include any applicable external references.> 
! 
! Author: J. Olson
! 
!-----------------------------------------------------------------------
   use shr_kind_mod, only: r8 => shr_kind_r8
   use ppgrid
   use phys_grid,    only: get_lat_p, get_lon_p
   use physconst,    only: gravit, latvap
   use constituents, only: qmin, pcnst
   use cam_logfile,  only: iulog
   use glb_verif_smry,only: tp_stat_smry, get_chunk_smry, current_number_of_smry_fields
   use perf_mod,      only: t_startf, t_stopf
   use phys_control, only: print_fixer_message

   implicit none

!
! Input arguments
!
   character*8, intent(in) :: subnam         ! name of calling routine
!
   integer, intent(in) :: lchnk              ! chunk index
   integer, intent(in) :: ncol               ! number of atmospheric columns
!
   real(r8), intent(in) :: ztodt             ! two times model timestep (2 delta-t)
   real(r8), intent(in) :: qbot(pcols,pcnst) ! moisture at lowest model level
   real(r8), intent(in) :: srfrpdel(pcols)   ! 1./(pint(K+1)-pint(K))
!
! Input/Output arguments
!
   real(r8), intent(inout) :: shflx(pcols)   ! Surface sensible heat flux (J/m2/s)
   real(r8), intent(inout) :: lhflx(pcols)   ! Surface latent   heat flux (J/m2/s)
   real(r8), intent(inout) :: qflx (pcols,pcnst)   ! surface water flux (kg/m^2/s)

! for get_chunk_smry

   real(r8), intent(in) :: lat(pcols)
   real(r8), intent(in) :: lon(pcols)
   type(tp_stat_smry),intent(inout) :: chunk_smry(current_number_of_smry_fields)

   logical, intent(in) :: l_old_qneg4_messages
!
!---------------------------Local workspace-----------------------------
!
   integer :: i,ii              ! longitude indices
   integer :: iw                ! i index of worst violator
   integer :: indxexc(pcols)    ! index array of points with excess flux
   integer :: nptsexc           ! number of points with excess flux
!
   real(r8):: worst             ! biggest violator
   real(r8):: excess(pcols)     ! Excess downward sfc latent heat flux
!
!-----------------------------------------------------------------------
!
! Compute excess downward (negative) q flux compared to a theoretical
! maximum downward q flux.  The theoretical max is based upon the
! given moisture content of lowest level of the model atmosphere.
!
   nptsexc = 0
   do i = 1,ncol
      excess(i) = qflx(i,1) - (qmin(1) - qbot(i,1))/(ztodt*gravit*srfrpdel(i))
!
! If there is an excess downward (negative) q flux, then subtract
! excess from "qflx" and "lhflx" and add to "shflx".
!
      if (excess(i) < 0._r8) then
         nptsexc = nptsexc + 1
         indxexc(nptsexc) = i
         qflx (i,1) = qflx (i,1) - excess(i)
         lhflx(i) = lhflx(i) - excess(i)*latvap
         shflx(i) = shflx(i) + excess(i)*latvap
      end if
   end do

!-------------------------------------------
! 2. Write out worst value if any excess <0 
! Zhun
! if (nptsexc.gt.0 .and. l_old_qneg4_messages) then
! Write out worst value if excess
!
   if (nptsexc.gt.0 .and. print_fixer_message) then
      worst = 0._r8
      do ii=1,nptsexc
         i = indxexc(ii)
         if (excess(i) < worst) then
            worst = excess(i)
            iw = i
         end if
      end do
      write(iulog,9000) subnam,nptsexc,worst, lchnk, iw, get_lat_p(lchnk,iw),get_lon_p(lchnk,iw)
   end if
!
9000 format(' QNEG4 WARNING from ',a8 &
            ,' Max possible LH flx exceeded at ',i5,' points. ' &
            ,', Worst excess = ',1pe12.4 &
            ,', lchnk = ',i5 &
            ,', i = ',i5 &
            ,', same as indices lat =', i5 &
            ,', lon =', i5 &
           )
!---------------------------------------------------------------
! 3. An alternative to 2: get chunk summary for concise message 

  call t_startf('get_chunk_smry')
  call get_chunk_smry('LHFLX_EXCESS @QNEG4_'//trim(subnam), &
                      ncol, excess(:ncol),lat(:ncol),lon(:ncol),chunk_smry(:) )
  call t_stopf('get_chunk_smry')
!---------------------------------------------------------
   return
end subroutine qneg4

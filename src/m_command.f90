module m_command
  implicit none
  private

  public :: command_t
  
  type, abstract :: command_t
    character(:), allocatable :: name
    contains 
    procedure(iexecute), deferred :: Execute
    procedure :: Command_Name
  end type command_t

  interface 
    subroutine iexecute(self)
      import command_t
      class(command_t), intent(in) :: self
    end subroutine iexecute
  end interface

  contains 

  function Command_Name(self) result(res)
    class(command_t), intent(in) :: self
    character(:), allocatable :: res
    res = self%name
  end function Command_Name
end module m_command

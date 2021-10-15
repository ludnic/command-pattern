module m_command_copy
  use m_command, only: command_t
  use m_command_argument, only: command_argument_t

  implicit none
  private 

  public :: command_copy_t

  type, extends(command_t) :: command_copy_t
    private
    type(command_argument_t), public :: arguments
    contains 
      procedure, public, pass(self) :: Execute
  end type command_copy_t

  interface command_copy_t
    module procedure :: constructor
  end interface command_copy_t

contains
  type(command_copy_t) function constructor()
    constructor%name = 'copy'
  end function constructor

  subroutine Execute(self)
    class(command_copy_t), intent(in) :: self
    
    print*, "Executing command ",self%Command_Name()
  end subroutine Execute
end module m_command_copy
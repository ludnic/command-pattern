module m_command_test
  use m_command, only: command_t
  use m_command_argument, only: command_argument_t

  implicit none
  private 

  public :: command_test_t

  type, extends(command_t) :: command_test_t
    private

    type(command_argument_t), public :: arguments
    contains 
      procedure, public, pass(self) :: Execute
  end type command_test_t

  interface command_test_t
    module procedure :: constructor
  end interface command_test_t

contains

  type(command_test_t) function constructor()
    constructor%name = 'test'
  end function constructor

  subroutine Execute(self)
    class(command_test_t), intent(in) :: self
    
    print*, "Executing command ",self%Command_Name()
  end subroutine Execute
  
end module m_command_test
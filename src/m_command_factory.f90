module m_command_factory
  use m_command, only: command_t 
  use m_command_argument, only: command_argument_t
  use m_command_test, only: command_test_t
  use m_command_copy, only: command_copy_t
  implicit none
  private 

  public :: command_factory_t

  ! Wrapper type to store polymorphic array of commands
  type :: commands_store_t
    class(command_t), allocatable :: command
  end type commands_store_t

  type :: command_factory_t 
    private
    type(commands_store_t), allocatable :: available_commands(:)
    contains 
      procedure, public :: Create_Command
  end type command_factory_t

  interface command_factory_t
    module procedure :: command_factory_constructor
  end interface command_factory_t
contains

  type(command_factory_t) function command_factory_constructor()
    associate(x => command_factory_constructor)
      allocate(x%available_commands(2))
      x%available_commands(1)%command = command_test_t()
      x%available_commands(2)%command = command_copy_t()
    end associate
  end function command_factory_constructor

  function Create_Command(self, arguments) result(cmd)
    class(command_factory_t), intent(in) :: self
    type(command_argument_t), intent(in) :: arguments
    class(command_t), allocatable :: cmd
    logical :: found
    integer :: i 

    found = .false. 
    do i = 1, size(self%available_commands)
      cmd = self%available_commands(i)%command
      if (cmd%Command_Name() == arguments%Get_Name()) then 
        found = .true. 
        exit
      endif
    enddo

    if (.not.found) then 
      error stop "Unknown command"
    endif 
  end function Create_Command

  
end module m_command_factory
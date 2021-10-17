module m_processor
  use m_command, only: command_t
  use m_command_argument, only: command_argument_t
  use m_command_copy, only: command_copy_t
  use m_command_test, only: command_test_t
  implicit none
  private 

  public :: processor_t

  ! Wrapper type to store polymorphic array of commands
  type :: commands_store_t
    class(command_t), allocatable :: command
  end type commands_store_t  

  type :: processor_t
    type(commands_store_t), allocatable :: available_commands(:)
    contains
      procedure, pass(self) :: Process
      procedure, pass(self), private :: Create_Command
  end type processor_t
  
  interface processor_t
    module procedure :: processor_constructor
  end interface processor_t
contains
  
  type(processor_t) function processor_constructor()
    associate(x => processor_constructor)
      allocate(x%available_commands(2))
      x%available_commands(1)%command = command_test_t()
      x%available_commands(2)%command = command_copy_t()
    end associate
  end function processor_constructor

  function Create_Command(self, arguments) result(cmd)
    class(processor_t), intent(in) :: self
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

  subroutine Process(self, args)
    character(*) :: args
    type(command_argument_t) :: arguments
    class(processor_t) :: self
    class(command_t), allocatable :: command

    call arguments%Parse(args)
    command = self%Create_Command(arguments)

    call command%Execute()
  end subroutine Process

end module m_processor

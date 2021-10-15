module m_processor
  use m_command, only: command_t
  use m_command_factory, only: command_factory_t
  use m_command_argument, only: command_argument_t
  implicit none
  private 

  public :: processor_t

  type :: processor_t
    type(command_factory_t), private :: command_factory
    contains
      procedure, pass(self) :: Process
  end type processor_t
  
  interface processor_t
    module procedure :: processor_constructor
  end interface processor_t
contains
  
  type(processor_t) function processor_constructor()
    processor_constructor%command_factory = command_factory_t()
  end function processor_constructor

  subroutine Process(self, args)
    character(*) :: args
    type(command_argument_t) :: arguments
    class(processor_t) :: self
    class(command_t), allocatable :: command

    call arguments%Parse(args)
    command = self%command_factory%Create_command(arguments)

    call command%Execute()
  end subroutine Process

end module m_processor

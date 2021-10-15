module m_command_argument
  use M_CLI2, only : set_args, get_args
  use M_CLI2, only : get_subcommand
  implicit none
  private
  
  public :: command_argument_t

  type :: command_argument_t
    private 
    character(:), allocatable, private :: command_name
  contains
    procedure, pass(self), public :: Parse
    procedure, public :: Get_Name
  end type command_argument_t

contains
  function Get_Name(self) result(name)
    class(command_argument_t), intent(in) :: self
    character(:), allocatable :: name

    name = self%command_name
  end function Get_Name

  subroutine Parse(self, args)
    class(command_argument_t), intent(inout) :: self
    character(*) :: args
    character(len=:), allocatable :: help_text(:), version_text(:)
    character(len=:), allocatable :: mode, start_date, stop_date, basin

    version_text=[character(len=80) :: &
      '@(#)PROGRAM:     demo6            >', &
      '@(#)DESCRIPTION: My demo program  >', &
      '@(#)VERSION:     1.0 20200715     >', &
      '@(#)AUTHOR:      me, myself, and I>', &
      '@(#)LICENSE:     Public Domain    >', &
      '' ]

    help_text=[character(len=80) :: &
     ' allowed subcommands are          ', &
     '   * run  -l -L -title -x -y -z   ', &
     '   * test -l -L -title            ', &
     '' ]

    args = get_subcommand()

    select case (args) 
    case('test')
      help_text=[character(len=80) :: &
      '                                  ', &
      ' Help for subcommand "test"   ', &
      '                                  ', &
      '' ]
      self%command_name = args
    case('copy')
      help_text=[character(len=80) :: &
      '                                  ', &
      ' Help for subcommand "copy"        ', &
      '                                  ', &
      '' ]
      self%command_name = args
    case default
      call set_args(' ', help_text, version_text)
      write(*,'(*(a))')'unknown or missing subcommand [',trim(args),']'
      write(*,'(a)')[character(len=80) ::  &
        ' allowed subcommands are          ', &
        '   * copy                         ', &
        '   * test                         ', &
        '' ]
      stop
    end select
  end subroutine Parse
  
end module m_command_argument
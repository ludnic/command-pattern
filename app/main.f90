program main
  use m_processor, only: processor_t
  implicit none

  type(processor_t) :: p
  character(len=50) :: args

  p = processor_t()
  call p%Process(args)
end program main

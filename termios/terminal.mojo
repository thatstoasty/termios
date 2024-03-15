from .c import termios, tcgetattr, tcsetattr


fn tc_get_attr(fd: Int32) raises -> termios:
    var termios_p = termios()
    var status = tcgetattr(fd, Pointer.address_of(termios_p))
    if status != 0:
        raise Error("Failed tcgetattr.")
    
    return termios_p


fn tc_set_attr(fd: Int32, optional_actions: Int32, termios_p: Pointer[termios]) raises -> Int32:
    var status = tcsetattr(fd, optional_actions, termios_p)
    if status != 0:
        raise Error("Failed tcsetattr.")
    
    return status


# fn tcsendbreak(fd: Int32, duration: Int32) -> Int32:
#     ...


# fn tcdrain(fd: Int32) -> Int32:
#     ...


# fn tcflush(fd: Int32, queue_selector: Int32) -> Int32:
#     ...


# fn tcflow(fd: Int32, action: Int32) -> Int32:
#     ...


# fn cfmakeraw(termios_p: Pointer[termios]) -> UInt8:
#     ...

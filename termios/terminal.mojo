from .c import termios, tcgetattr, tcsetattr, tcsendbreak, tcdrain, tcflush, tcflow, TCSADRAIN, TCSAFLUSH, TCSANOW


fn tc_get_attr(fd: Int32) raises -> termios:
    var termios_p = termios()
    var status = tcgetattr(fd, Pointer.address_of(termios_p))
    if status != 0:
        raise Error("Failed tcgetattr." + str(status))
    
    return termios_p


fn tc_set_attr(fd: Int32, optional_actions: Int32, termios_p: Pointer[termios]) raises -> Int32:
    """Set the tty attributes for file descriptor fd from the attributes, which is a list like the one returned by tcgetattr(). The when argument determines when the attributes are changed:
    termios.TCSANOW
        Change attributes immediately.

    termios.TCSADRAIN
        Change attributes after transmitting all queued output.

    termios.TCSAFLUSH
        Change attributes after transmitting all queued output and discarding all queued input.
    
    Args:
        fd: File descriptor.
        optional_actions: When to change the attributes.
        termios_p: Pointer to termios struct.
    
    Returns:
        Int32: status.
    """
    var status = tcsetattr(fd, optional_actions, termios_p)
    if status != 0:
        raise Error("Failed tcsetattr." + str(status))
    
    return status


fn tc_send_break(fd: Int32, duration: Int32) raises -> Int32:
    """Send a break on file descriptor fd. A zero duration sends a break for 0.25 - 0.5 seconds; a nonzero duration has a system dependent meaning.
    
    Args:
        fd: File descriptor.
        duration: Duration of break.
    
    Returns:
        Int32: status.
    """
    var status = tcsendbreak(fd, duration)
    if status != 0:
        raise Error("Failed tcsendbreak." + str(status))
    
    return status


fn tc_drain(fd: Int32) raises -> Int32:
    """Wait until all output written to the object referred to by fd has been transmitted.

    Args:
        fd: File descriptor.
    
    Returns:
        Int32: status.
    """
    var status = tcdrain(fd)
    if status != 0:
        raise Error("Failed tcdrain." + str(status))
    
    return status


fn tc_flush(fd: Int32, queue_selector: Int32) raises -> Int32:
    """Discard queued data on file descriptor fd. The queue selector specifies which queue: TCIFLUSH for the input queue, TCOFLUSH for the output queue, or TCIOFLUSH for both queues.
    
    Args:
        fd: File descriptor.
        queue_selector: Queue selector.
    
    Returns:
        Int32: status.
    """
    var status = tcflush(fd, queue_selector)
    if status != 0:
        raise Error("Failed tcflush." + str(status))
    
    return status


fn tc_flow(fd: Int32, action: Int32) raises -> Int32:
    """Suspend or resume input or output on file descriptor fd. The action argument can be TCOOFF to suspend output, TCOON to restart output, TCIOFF to suspend input, or TCION to restart input.
    
    Args:
        fd: File descriptor.
        action: Action.
    
    Returns:
        Int32: status.
    """
    var status = tcflow(fd, action)
    if status != 0:
        raise Error("Failed tcflow." + str(status))
    
    return status


# Not available from libc
# fn tc_getwinsize(fd: Int32) raises -> winsize:
#     """Return the window size of the terminal associated to file descriptor fd as a winsize object. The winsize object is a named tuple with four fields: ws_row, ws_col, ws_xpixel, and ws_ypixel.
#     """
#     var winsize_p = winsize()
#     var status = tcgetwinsize(fd, Pointer.address_of(winsize_p))
#     if status != 0:
#         raise Error("Failed tcgetwinsize." + str(status))
    
#     return winsize_p


# fn tc_setwinsize(fd: Int32, winsize: Int32) raises -> Int32:
#     var status = tcsetwinsize(fd, winsize)
#     if status != 0:
#         raise Error("Failed tcsetwinsize." + str(status))
    
#     return status

import .c


fn tcgetattr(file_descriptor: c.c_int) raises -> c.Termios:
    """Return the tty attributes for file descriptor.
    This is a wrapper around `c.tcgetattr()`.

    Args:
        file_descriptor: File descriptor.

    Returns:
        Termios struct.
    """
    var termios_p = c.Termios()
    var status = c.tcgetattr(file_descriptor, Reference(termios_p))
    if status != 0:
        raise Error("Failed c.tcgetattr. Status: " + str(status))

    return termios_p


fn tcsetattr(file_descriptor: c.c_int, optional_actions: c.c_int, inout termios_p: c.Termios) raises -> None:
    """Set the tty attributes for file descriptor file_descriptor from the attributes, which is a list like the one returned by c.tcgetattr(). The when argument determines when the attributes are changed:
    This is a wrapper around `c.tcsetattr()`.

    `termios.TCSANOW`
        Change attributes immediately.

    `termios.TCSADRAIN`
        Change attributes after transmitting all queued output.

    `termios.TCSAFLUSH`
        Change attributes after transmitting all queued output and discarding all queued input.

    Args:
        file_descriptor: File descriptor.
        optional_actions: When to change the attributes.
        termios_p: Pointer to Termios struct.
    """
    var status = c.tcsetattr(file_descriptor, optional_actions, Reference(termios_p))
    if status != 0:
        raise Error("Failed c.tcsetattr. Status: " + str(status))


fn tcsendbreak(file_descriptor: c.c_int, duration: c.c_int) raises -> None:
    """Send a break on file descriptor `file_descriptor`. A zero duration sends a break for 0.25 - 0.5 seconds; a nonzero duration has a system dependent meaning.

    Args:
        file_descriptor: File descriptor.
        duration: Duration of break.
    """
    var status = c.tcsendbreak(file_descriptor, duration)
    if status != 0:
        raise Error("Failed c.tcsendbreak. Status: " + str(status))


fn tcdrain(file_descriptor: c.c_int) raises -> None:
    """Wait until all output written to the object referred to by `file_descriptor` has been transmitted.

    Args:
        file_descriptor: File descriptor.
    """
    var status = c.tcdrain(file_descriptor)
    if status != 0:
        raise Error("Failed c.tcdrain. Status: " + str(status))


fn tcflush(file_descriptor: c.c_int, queue_selector: c.c_int) raises -> None:
    """Discard queued data on file descriptor `file_descriptor`.
    The queue selector specifies which queue:
    - `TCIFLUSH` for the input queue
    - `TCOFLUSH` for the output queue
    - `TCIOFLUSH` for both queues.

    Args:
        file_descriptor: File descriptor.
        queue_selector: Queue selector.
    """
    var status = c.tcflush(file_descriptor, queue_selector)
    if status != 0:
        raise Error("Failed c.tcflush. Status: " + str(status))


fn tcflow(file_descriptor: c.c_int, action: c.c_int) raises -> None:
    """Suspend or resume input or output on file descriptor `file_descriptor`.
    The action argument can be:
    - `TCOOFF` to suspend output
    - `TCOON` to restart output
    - `TCIOFF` to suspend input
    - `TCION` to restart input.

    Args:
        file_descriptor: File descriptor.
        action: Action.

    """
    var status = c.tcflow(file_descriptor, action)
    if status != 0:
        raise Error("Failed c.tcflow, Status: " + str(status))


# Not available from libc
# fn tc_getwinsize(file_descriptor: c.c_int) raises -> winsize:
#     """Return the window size of the terminal associated to file descriptor file_descriptor as a winsize object. The winsize object is a named tuple with four fields: ws_row, ws_col, ws_xpixel, and ws_ypixel.
#     """
#     var winsize_p = winsize()
#     var status = tcgetwinsize(file_descriptor, Pointer.address_of(winsize_p))
#     if status != 0:
#         raise Error("Failed tcgetwinsize." + str(status))

#     return winsize_p


# fn tc_setwinsize(file_descriptor: c.c_int, winsize: Int32) raises -> Int32:
#     var status = tcsetwinsize(file_descriptor, winsize)
#     if status != 0:
#         raise Error("Failed tcsetwinsize." + str(status))

#     return status

from .c import (
    Termios,
    tcgetattr,
    tcsetattr,
    tcsendbreak,
    tcdrain,
    tcflush,
    tcflow,
    c_int
)
import .c


fn get_tty_attributes(file_descriptor: c_int) raises -> Termios:
    """Return the tty attributes for file descriptor.
    This is a wrapper around tcgetattr().

    Args:
        file_descriptor: File descriptor.

    Returns:
        Termios struct.
    """
    var termios_p = Termios()
    var status = tcgetattr(file_descriptor, termios_p)
    if status != 0:
        raise Error("Failed tcgetattr. Status: " + str(status))

    return termios_p^


fn set_tty_attributes(
    file_descriptor: c_int, optional_actions: c_int, inout termios_p: Termios
) raises -> None:
    """Set the tty attributes for file descriptor file_descriptor from the attributes, which is a list like the one returned by tcgetattr(). The when argument determines when the attributes are changed:
    This is a wrapper around tcsetattr().

    termios.TCSANOW
        Change attributes immediately.

    termios.TCSADRAIN
        Change attributes after transmitting all queued output.

    termios.TCSAFLUSH
        Change attributes after transmitting all queued output and discarding all queued input.

    Args:
        file_descriptor: File descriptor.
        optional_actions: When to change the attributes.
        termios_p: Pointer to Termios struct.
    """
    var status = tcsetattr(file_descriptor, optional_actions, termios_p)
    if status != 0:
        raise Error("Failed tcsetattr. Status: " + str(status))


fn send_break(file_descriptor: c_int, duration: c_int) raises -> None:
    """Send a break on file descriptor file_descriptor. A zero duration sends a break for 0.25 - 0.5 seconds; a nonzero duration has a system dependent meaning.

    Args:
        file_descriptor: File descriptor.
        duration: Duration of break.
    """
    var status = tcsendbreak(file_descriptor, duration)
    if status != 0:
        raise Error("Failed tcsendbreak. Status: " + str(status))


fn drain(file_descriptor: c_int) raises -> None:
    """Wait until all output written to the object referred to by file_descriptor has been transmitted.

    Args:
        file_descriptor: File descriptor.
    """
    var status = tcdrain(file_descriptor)
    if status != 0:
        raise Error("Failed tcdrain. Status: " + str(status))


fn flush(file_descriptor: c_int, queue_selector: c_int) raises -> None:
    """Discard queued data on file descriptor file_descriptor. 
    The queue selector specifies which queue: 
    - TCIFLUSH for the input queue
    - TCOFLUSH for the output queue
    - TCIOFLUSH for both queues.

    Args:
        file_descriptor: File descriptor.
        queue_selector: Queue selector.
    """
    var status = tcflush(file_descriptor, queue_selector)
    if status != 0:
        raise Error("Failed tcflush. Status: " + str(status))


fn flow(file_descriptor: c_int, action: c_int) raises -> None:
    """Suspend or resume input or output on file descriptor `file_descriptor`.
    The action argument can be:
    - TCOOFF to suspend output
    - TCOON to restart output
    - TCIOFF to suspend input
    - TCION to restart input.

    Args:
        file_descriptor: File descriptor.
        action: Action.

    """
    var status = tcflow(file_descriptor, action)
    if status != 0:
        raise Error("Failed tcflow, Status: " + str(status))


# Not available from libc
# fn tc_getwinsize(file_descriptor: c_int) raises -> winsize:
#     """Return the window size of the terminal associated to file descriptor file_descriptor as a winsize object. The winsize object is a named tuple with four fields: ws_row, ws_col, ws_xpixel, and ws_ypixel.
#     """
#     var winsize_p = winsize()
#     var status = tcgetwinsize(file_descriptor, Pointer.address_of(winsize_p))
#     if status != 0:
#         raise Error("Failed tcgetwinsize." + str(status))

#     return winsize_p


# fn tc_setwinsize(file_descriptor: c_int, winsize: Int32) raises -> Int32:
#     var status = tcsetwinsize(file_descriptor, winsize)
#     if status != 0:
#         raise Error("Failed tcsetwinsize." + str(status))

#     return status

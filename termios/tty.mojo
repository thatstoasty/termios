from .c.terminal import (
    termios,
    ECHO,
    ICANON,
    VMIN,
    VTIME,
    TCSAFLUSH,
    IGNBRK,
    BRKINT,
    IGNPAR,
    PARMRK,
    INPCK,
    ISTRIP,
    INLCR,
    IGNCR,
    ICRNL,
    IXON,
    IXANY,
    IXOFF,
    OPOST,
    PARENB,
    CSIZE,
    CS8,
    ECHOE,
    ECHOK,
    ECHONL,
    IEXTEN,
    ISIG,
    NOFLSH,
    TOSTOP,
)
from .terminal import tc_get_attr, tc_set_attr

# Indices for termios list.
alias IFLAG = 0
alias OFLAG = 1
alias CFLAG = 2
alias LFLAG = 3
alias ISPEED = 4
alias OSPEED = 5
alias CC = 6


fn cfmakeraw(inout mode: termios):
    """Make termios mode raw."""
    # Clear all POSIX.1-2017 input mode flags.
    # See chapter 11 "General Terminal Interface"
    # of POSIX.1-2017 Base Definitions.
    mode.c_iflag &= ~(
        IGNBRK
        | BRKINT
        | IGNPAR
        | PARMRK
        | INPCK
        | ISTRIP
        | INLCR
        | IGNCR
        | ICRNL
        | IXON
        | IXANY
        | IXOFF
    )

    # Do not post-process output.
    mode.c_oflag &= ~OPOST

    # Disable parity generation and detection; clear character size mask;
    # let character size be 8 bits.
    mode.c_cflag &= ~(PARENB | CSIZE)
    mode.c_cflag |= CS8

    # Clear all POSIX.1-2017 local mode flags.
    mode.c_lflag &= ~(
        ECHO | ECHOE | ECHOK | ECHONL | ICANON | IEXTEN | ISIG | NOFLSH | TOSTOP
    )

    # POSIX.1-2017, 11.1.7 Non-Canonical Mode Input Processing,
    # Case B: MIN>0, TIME=0
    # A pending read shall block until MIN (here 1) bytes are received,
    # or a signal is received.
    # mode.c_cc = list(mode[CC])
    mode.c_cc[VMIN] = 1
    mode.c_cc[VTIME] = 0


fn cfmakecbreak(inout mode: termios):
    """Make termios mode cbreak."""
    # Do not echo characters; disable canonical input.
    mode.c_lflag &= ~(ECHO | ICANON)

    # POSIX.1-2017, 11.1.7 Non-Canonical Mode Input Processing,
    # Case B: MIN>0, TIME=0
    # A pending read shall block until MIN (here 1) bytes are received,
    # or a signal is received.
    # mode[CC] = list(mode[CC])
    mode.c_cc[VMIN] = 1
    mode.c_cc[VTIME] = 0


fn setraw(fd: Int, when: Int = TCSAFLUSH) raises -> termios:
    """Put terminal into raw mode."""
    var mode = tc_get_attr(fd)
    cfmakeraw(mode)
    var status = tc_set_attr(fd, when, Pointer.address_of(mode))
    if status != 0:
        raise Error("setraw failed at tc_set_attr")
    return mode


fn setcbreak(fd: Int, when: Int = TCSAFLUSH) raises -> termios:
    """Put terminal into cbreak mode."""
    var mode = tc_get_attr(fd)
    cfmakecbreak(mode)
    var status = tc_set_attr(fd, when, Pointer.address_of(mode))
    if status != 0:
        raise Error("setraw failed at tc_set_attr")
    return mode

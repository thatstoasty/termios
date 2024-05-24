from .c.terminal import (
    Termios,
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
from .terminal import get_tty_attributes, set_tty_attributes
from time import now

# Indices for Termios list.
alias IFLAG = 0
alias OFLAG = 1
alias CFLAG = 2
alias LFLAG = 3
alias ISPEED = 4
alias OSPEED = 5
alias CC = 6


fn set_control_flags_to_raw_mode(inout mode: Termios):
    """Make Termios mode raw.
    This is roughly equivalent to CPython's cfmakeraw().

    - Turns off post-processing of output.
    - Disables parity generation and detection.
    - Sets character size to 8 bits.
    - Blocks until 1 byte is read.

    Raw mode sets up the TTY driver to pass every character to the program as it is typed.
    """
    # Clear all POSIX.1-2017 input mode flags.
    # See chapter 11 "General Terminal Interface"
    # of POSIX.1-2017 Base Definitions.
    mode.input_flags &= ~(
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
    mode.output_flags &= ~OPOST

    # Disable parity generation and detection; clear character size mask;
    # let character size be 8 bits.
    mode.control_flags &= ~(PARENB | CSIZE)
    mode.control_flags |= CS8

    # Clear all POSIX.1-2017 local mode flags.
    mode.local_flags &= ~(
        ECHO | ECHOE | ECHOK | ECHONL | ICANON | IEXTEN | ISIG | NOFLSH | TOSTOP
    )

    # POSIX.1-2017, 11.1.7 Non-Canonical Mode Input Processing,
    # Case B: MIN>0, TIME=0
    # A pending read shall block until MIN (here 1) bytes are received,
    # or a signal is received.
    mode.control_characters[VMIN] = 1
    mode.control_characters[VTIME] = 0


fn set_control_flags_to_cbreak(inout mode: Termios):
    """Make Termios mode cbreak.
    This is roughly equivalent to CPython's cfmakecbreak().

    - Turns off character echoing.
    - Disables canonical input.
    - Blocks until 1 byte is read.

    Args:
        mode: Termios instance to modify in place.
    """
    # Do not echo characters; disable canonical input.
    mode.local_flags &= ~(ECHO | ICANON)

    # POSIX.1-2017, 11.1.7 Non-Canonical Mode Input Processing,
    # Case B: MIN>0, TIME=0
    # A pending read shall block until MIN (here 1) bytes are received,
    # or a signal is received.
    mode.control_characters[VMIN] = 1
    mode.control_characters[VTIME] = 0


fn set_tty_to_raw(file_descriptor: Int, when: Int = TCSAFLUSH) -> (Termios, Error):
    """Set terminal to raw mode.

    Args:
        file_descriptor: File descriptor of the terminal.
        when: When to apply the changes. Default is TCSAFLUSH.

    Returns:
        The original terminal attributes, and an error if any.
    """
    var mode: Termios
    var err: Error
    mode, err = get_tty_attributes(file_descriptor)
    if err:
        return mode, err

    var new = mode
    set_control_flags_to_raw_mode(new)

    var status: Int32
    status, err = set_tty_attributes(file_descriptor, when, UnsafePointer(new))
    if status != 0:
        return mode, Error("set_tty_to_raw: failed at set_tty_attributes")

    return mode, Error()


fn set_tty_to_cbreak(file_descriptor: Int, when: Int = TCSAFLUSH) -> (Termios, Error):
    """Set terminal to cbreak mode.

    Args:
        file_descriptor: File descriptor of the terminal.
        when: When to apply the changes. Default is TCSAFLUSH.

    Returns:
        The original terminal attributes, and an error if any.
    """
    var mode: Termios
    var err: Error
    mode, err = get_tty_attributes(file_descriptor)
    if err:
        return mode, err

    var new = mode
    set_control_flags_to_cbreak(new)

    var status: Int32
    status, err = set_tty_attributes(file_descriptor, when, UnsafePointer(new))
    if status != 0:
        return mode, Error("set_tty_to_raw: failed at set_tty_attributes")

    return mode, Error()

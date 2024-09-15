from .c import (
    Termios,
    ControlMode,
    LocalMode,
    InputMode,
    OutputMode,
    ControlCharacter,
    TTYWhen,
    TTYFlow,
    CS8,
    c_int
)
from .terminal import get_tty_attributes, set_tty_attributes

# Indices for Termios list.
alias IFLAG = 0
alias OFLAG = 1
alias CFLAG = 2
alias LFLAG = 3
alias ISPEED = 4
alias OSPEED = 5
alias CC = 6


fn cfmakeraw(inout mode: Termios):
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
    mode.c_iflag &= ~(
        InputMode.IGNBRK
        | InputMode.BRKINT
        | InputMode.IGNPAR
        | InputMode.PARMRK
        | InputMode.INPCK
        | InputMode.ISTRIP
        | InputMode.INLCR
        | InputMode.IGNCR
        | InputMode.ICRNL
        | InputMode.IXON
        | InputMode.IXANY
        | InputMode.IXOFF
    )

    # Do not post-process output.
    mode.c_oflag &= ~OutputMode.OPOST

    # Disable parity generation and detection; clear character size mask;
    # let character size be 8 bits.
    mode.c_cflag &= ~(ControlMode.PARENB | ControlMode.CSIZE)
    mode.c_cflag |= CS8

    # Clear all POSIX.1-2017 local mode flags.
    mode.c_lflag &= ~(
        LocalMode.ECHO | LocalMode.ECHOE | LocalMode.ECHOK | LocalMode.ECHONL | LocalMode.ICANON | LocalMode.IEXTEN | LocalMode.ISIG | LocalMode.NOFLSH | LocalMode.TOSTOP
    )

    # POSIX.1-2017, 11.1.7 Non-Canonical Mode Input Processing,
    # Case B: MIN>0, TIME=0
    # A pending read shall block until MIN (here 1) bytes are received,
    # or a signal is received.
    mode.c_cc[ControlCharacter.VMIN] = 1
    mode.c_cc[ControlCharacter.VTIME] = 0


fn cfmakecbreak(inout mode: Termios):
    """Make Termios mode cbreak.
    This is roughly equivalent to CPython's cfmakecbreak().

    - Turns off character echoing.
    - Disables canonical input.
    - Blocks until 1 byte is read.

    Args:
        mode: Termios instance to modify in place.
    """
    # Do not echo characters; disable canonical input.
    mode.c_lflag &= ~(LocalMode.ECHO | LocalMode.ICANON)

    # POSIX.1-2017, 11.1.7 Non-Canonical Mode Input Processing,
    # Case B: MIN>0, TIME=0
    # A pending read shall block until MIN (here 1) bytes are received,
    # or a signal is received.
    mode.c_cc[ControlCharacter.VMIN] = 1
    mode.c_cc[ControlCharacter.VTIME] = 0


fn set_tty_to_raw(file_descriptor: c_int, when: Int = TTYWhen.TCSAFLUSH) raises -> Termios:
    """Set terminal to raw mode.

    Args:
        file_descriptor: File descriptor of the terminal.
        when: When to apply the changes. Default is TCSAFLUSH.

    Returns:
        The original terminal attributes, and an error if any.
    """
    var mode = get_tty_attributes(file_descriptor)
    var new = mode
    cfmakeraw(new)
    set_tty_attributes(file_descriptor, when, new)

    return mode


fn set_tty_to_cbreak(file_descriptor: c_int, when: Int = TTYWhen.TCSAFLUSH) raises -> Termios:
    """Set terminal to cbreak mode.

    Args:
        file_descriptor: File descriptor of the terminal.
        when: When to apply the changes. Default is TCSAFLUSH.

    Returns:
        The original terminal attributes, and an error if any.
    """
    var mode = get_tty_attributes(file_descriptor)
    var new = mode
    cfmakecbreak(new)
    set_tty_attributes(file_descriptor, when, new)

    return mode

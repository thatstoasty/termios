from utils import StaticTuple
from sys import external_call, os_is_macos

# C types
alias void = UInt8
alias char = UInt8
alias schar = Int8
alias uchar = UInt8
alias short = Int16
alias ushort = UInt16
alias c_int = Int32
alias uint = UInt32
alias long = Int64
alias ulong = UInt64
alias float = Float32
alias double = Float64
alias size_t = UInt
alias ssize_t = Int
alias cc_t = UInt8
alias speed_t = UInt64
alias NCCS = Int8

alias tcflag_t = UInt64

# alias tcflag_t = UInt32
# alias speed_t = UInt32
# 64bit system


struct FD():
    alias FD_STDIN = 0
    alias FD_STDOUT = 1
    alias FD_STDERR = 2


# control_flags values
struct ControlMode():
    alias CREAD = 2048 if os_is_macos() else 128
    alias CLOCAL = 32768 if os_is_macos() else 2048
    alias PARENB = 4096 if os_is_macos() else 256
    alias CSIZE = 768 if os_is_macos() else 48

# local_flags values
struct LocalMode():
    alias ICANON = 256 if os_is_macos() else 2
    alias ECHO = 8 if os_is_macos() else 1
    alias ECHOE = 2 if os_is_macos() else 16
    alias ECHOK = 4 if os_is_macos() else 32
    alias ECHONL = 16 if os_is_macos() else 64
    alias ISIG = 128 if os_is_macos() else 1
    alias IEXTEN = 1024 if os_is_macos() else 32768
    alias NOFLSH = 2147483648 if os_is_macos() else 128
    alias TOSTOP = 4194304 if os_is_macos() else 256


# output_flags values
struct OutputMode():
    alias OPOST = 1

# input_flags values
struct InputMode():
    alias INLCR = 64
    alias IGNCR = 128
    alias ICRNL = 256
    alias IGNBRK = 1
    """Ignore BREAK condition on input.
    If IGNBRK is set, a BREAK is ignored.  If it is not set
    but BRKINT is set, then a BREAK causes the input and
    output queues to be flushed, and if the terminal is the
    controlling terminal of a foreground process group, it
    will cause a SIGINT to be sent to this foreground process
    group.  When neither IGNBRK nor BRKINT are set, a BREAK
    reads as a null byte ('\\0'), except when PARMRK is set, in
    which case it reads as the sequence \\377 \\0 \\0."""
    alias BRKINT = 2
    alias IGNPAR = 4
    """Ignore framing errors and parity errors.
    If this bit is set, input bytes with parity or framing
    errors are marked when passed to the program.  This bit is
    meaningful only when INPCK is set and IGNPAR is not set.
    The way erroneous bytes are marked is with two preceding
    bytes, \\377 and \\0.  Thus, the program actually reads
    three bytes for one erroneous byte received from the
    terminal.  If a valid byte has the value \\377, and ISTRIP
    (see below) is not set, the program might confuse it with
    the prefix that marks a parity error.  Therefore, a valid
    byte \\377 is passed to the program as two bytes, \\377
    \\377, in this case."""

    # If neither IGNPAR nor PARMRK is set, read a character with
    # a parity error or framing error as \0.

    alias PARMRK = 8
    alias INPCK = 16  # Enable input parity checking.
    alias ISTRIP = 32  # Strip off eighth bit.

    # alias INLCR  Translate NL to CR on input.

    # alias IGNCR  Ignore carriage return on input.

    # alias ICRNL  Translate carriage return to newline on input (unless
    #         IGNCR is set).

    # alias IUCLC  (not in POSIX) Map uppercase characters to lowercase on
    #         input.

    alias IXON = 512 if os_is_macos() else 1024
    """Enable XON/XOFF flow control on output."""
    alias IXANY = 2048
    """(XSI) Typing any character will restart stopped output. (The default is to allow just the START character to restart output.)"""
    alias IXOFF = 1024 if os_is_macos() else 4096
    """Enable XON/XOFF flow control on input."""

    # alias IMAXBEL
    #         (not in POSIX) Ring bell when input queue is full.  Linux
    #         does not implement this bit, and acts as if it is always
    #         set.

    # alias IUTF8 (since Linux 2.6.4)
    #         (not in POSIX) Input is UTF8; this allows character-erase
    #         to be correctly performed in cooked mode.

struct ControlCharacter():
    # Special Character indexes for control_characters
    alias VEOF = 0
    """Signal End-Of-Input `Ctrl-D`"""
    alias VEOL = 1
    """Signal End-Of-Line `Disabled`"""
    alias VERASE = 3
    """Delete previous character `Backspace`"""
    alias VINTR = 8
    """Generate SIGINT `Ctrl-C`"""
    alias VKILL = 5
    """Erase current line `Ctrl-U`"""
    alias VMIN = 16
    """The MIN value `1`"""
    alias VQUIT = 9
    """Generate SIGQUIT `Ctrl-\\`"""
    alias VSTART = 12
    """Resume output `Ctrl-Q`"""
    alias VSTOP = 13
    """Suspend output `Ctrl-S`"""
    alias VSUSP = 10
    """Suspend program `Ctrl-Z`"""
    alias VTIME = 17
    """TIME value `0`"""

alias CS8 = 768


struct TTYWhen():
    """TTY when values."""
    alias TCSADRAIN = 1
    alias TCSAFLUSH = 2
    alias TCSANOW = 0
    alias TCSASOFT = 16

struct TTYFlow():
    """TTY flow actions."""
    alias TCOOFF = 1
    alias TCOON = 2
    alias TCOFLUSH = 2
    alias TCIOFLUSH = 3


# define NCCS 12
@value
struct Termios():
    var c_iflag: tcflag_t
    """Input mode flags."""
    var c_oflag: tcflag_t
    """Output mode flags."""
    var c_cflag: tcflag_t
    """Control mode flags."""
    var c_lflag: tcflag_t
    """Local mode flags."""
    var c_cc: StaticTuple[cc_t, 20]
    """Special control characters."""
    var c_ispeed: speed_t
    """Input baudrate."""
    var c_ospeed: speed_t
    """Output baudrate."""

    fn __init__(inout self):
        self.c_cc = StaticTuple[cc_t, 20](0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        self.c_cflag = 0
        self.c_lflag = 0
        self.c_iflag = 0
        self.c_oflag = 0
        self.c_ispeed = 0
        self.c_ospeed = 0


fn tcgetattr(fd: c_int, inout termios_p: Termios) -> c_int:
    """Libc POSIX `tcgetattr` function
    Reference: https://man7.org/linux/man-pages/man3/tcgetattr.3.html
    Fn signature: int tcgetattr(int fd, struct Termios *termios_p).

    Args:
        fd: File descriptor.
        termios_p: Pointer to a Termios struct.
    """
    return external_call["tcgetattr", c_int](fd, Reference(termios_p))


fn tcsetattr(fd: c_int, optional_actions: c_int, owned termios_p: Termios) -> c_int:
    """Libc POSIX `tcsetattr` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcsetattr(int fd, int optional_actions, const struct Termios *termios_p).

    Args:
        fd: File descriptor.
        optional_actions: Optional actions.
        termios_p: Pointer to a Termios struct.
    """
    return external_call["tcsetattr", c_int](fd, optional_actions, Reference(termios_p))


fn tcsendbreak(fd: c_int, duration: c_int) -> c_int:
    """Libc POSIX `tcsendbreak` function
    Reference: https://man7.org/linux/man-pages/man3/tcsendbreak.3.html
    Fn signature: int tcsendbreak(int fd, int duration);.

    Args:
        fd: File descriptor.
        duration: Duration.
    """
    return external_call["tcsendbreak", c_int, c_int, c_int](fd, duration)


fn tcdrain(fd: c_int) -> c_int:
    """Libc POSIX `tcdrain` function
    Reference: https://man7.org/linux/man-pages/man3/tcdrain.3.html
    Fn signature: int tcdrain(int fd).

    Args:
        fd: File descriptor.
    """
    return external_call["tcdrain", c_int, c_int](fd)


fn tcflush(fd: c_int, queue_selector: c_int) -> c_int:
    """Libc POSIX `tcflush` function
    Reference: https://man7.org/linux/man-pages/man3/tcflush.3.html
    Fn signature: int tcflush(int fd, int queue_selector);.

    Args:
        fd: File descriptor.
        queue_selector: Queue selector.
    """
    return external_call["tcflush", c_int, c_int, c_int](fd, queue_selector)


fn tcflow(fd: c_int, action: c_int) -> c_int:
    """Libc POSIX `tcflow` function
    Reference: https://man7.org/linux/man-pages/man3/tcflow.3.html
    Fn signature: int tcflow(int fd, int action).

    Args:
        fd: File descriptor.
        action: Action.
    """
    return external_call["tcflow", c_int, c_int, c_int](fd, action)


fn cfmakeraw(termios_p: Reference[Termios]) -> void:
    """Libc POSIX `cfmakeraw` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: void cfmakeraw(struct Termios *termios_p).

    Args:
        termios_p: Pointer to a Termios struct.
    """
    return external_call["cfmakeraw", void](termios_p)


# @value
# @register_passable("trivial")
# struct winsize():
#     var ws_row: UInt8      # Number of rows, in characters */
#     var ws_col: UInt8      # Number of columns, in characters */
#     var ws_xpixel: UInt8   # Width, in pixels */
#     var ws_ypixel: UInt8   # Height, in pixels */

#     fn __init__(inout self):
#         self.ws_row = 0
#         self.ws_col = 0
#         self.ws_xpixel = 0
#         self.ws_ypixel = 0


# fn tcgetwinsize(fd: c_int, winsize_p: UnsafePointer[winsize]) -> c_int:
#     """Libc POSIX `tcgetwinsize` function
#     Reference: https://man.netbsd.org/tcgetwinsize.3
#     Fn signature: int tcgetwinsize(int fd, struct winsize *gws).

#     Args:
#         fd: File descriptor.
#         winsize_p: Pointer to a winsize struct.
#     """
#     return external_call["tcgetwinsize", c_int, c_int, UnsafePointer[winsize]](fd, winsize_p)


# fn tcsetwinsize(fd: c_int, winsize_p: UnsafePointer[winsize]) -> c_int:
#     """Libc POSIX `tcgetwinsize` function
#     Reference: https://man.netbsd.org/tcsetwinsize.3
#     Fn signature: int tcsetwinsize(int fd, const struct winsize *sws).

#     Args:
#         fd: File descriptor.
#         winsize_p: Pointer to a winsize struct.
#     """
#     return external_call["tcsetwinsize", c_int, c_int, UnsafePointer[winsize]](fd, winsize_p)

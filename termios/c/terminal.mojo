# Adapted from https://github.com/crisadamo/mojo-Libc . Huge thanks to Cristian!
# C types
alias c_void = UInt8
alias c_char = UInt8
alias c_schar = Int8
alias c_uchar = UInt8
alias c_short = Int16
alias c_ushort = UInt16
alias c_int = Int32
alias c_uint = UInt32
alias c_long = Int64
alias c_ulong = UInt64
alias c_float = Float32
alias c_double = Float64

# `Int` is known to be machine's width
alias c_size_t = Int
alias c_ssize_t = Int

alias ptrdiff_t = Int64
alias intptr_t = Int64
alias uintptr_t = UInt64

alias cc_t = UInt8
alias tcflag_t = UInt32
alias speed_t = UInt32
alias NCCS = Int8

alias FD_STDIN: c_int = 0
alias FD_STDOUT: c_int = 1
alias FD_STDERR: c_int = 2

# control_flags values
alias CREAD = 2048
alias CLOCAL = 32768

# local_flags values
alias ICANON = 256
alias ECHO = 8
alias ECHOE = 2
alias ECHOK = 4
alias ECHONL = 16
alias ISIG = 128
alias IEXTEN = 1024

# output_flags values
alias OPOST = 1

# input_flags values
alias INLCR = 64
alias IGNCR = 128
alias ICRNL = 256
alias IGNBRK = 1  # Ignore BREAK condition on input.

# Special Character indexes for control_characters
alias VEOF = 1  # Signal End-Of-Input	Ctrl-D
alias VEOL = 2  # Signal End-Of-Line	[Disabled]
alias VERASE = 3  # Delete previous character	Backspace
alias VINTR = 4  # Generate SIGINT	Ctrl-C
alias VKILL = 5  # 	Erase current line	Ctrl-U
alias VMIN = 6  # 	The MIN value	1
alias VQUIT = 7  # 	Generate SIGQUIT	Ctrl-\
alias VSTART = 8  # 	Resume output	Ctrl-Q
alias VSTOP = 9  # Suspend output	Ctrl-S
alias VSUSP = 10  # Suspend program	Ctrl-Z
alias VTIME = 11  # TIME value	0

# If IGNBRK is set, a BREAK is ignored.  If it is not set
# but BRKINT is set, then a BREAK causes the input and
# output queues to be flushed, and if the terminal is the
# controlling terminal of a foreground process group, it
# will cause a SIGINT to be sent to this foreground process
# group.  When neither IGNBRK nor BRKINT are set, a BREAK
# reads as a null byte ('\0'), except when PARMRK is set, in
# which case it reads as the sequence \377 \0 \0.
alias BRKINT = 1
alias IGNPAR = 2  # Ignore framing errors and parity errors.
# If this bit is set, input bytes with parity or framing
# errors are marked when passed to the program.  This bit is
# meaningful only when INPCK is set and IGNPAR is not set.
# The way erroneous bytes are marked is with two preceding
# bytes, \377 and \0.  Thus, the program actually reads
# three bytes for one erroneous byte received from the
# terminal.  If a valid byte has the value \377, and ISTRIP
# (see below) is not set, the program might confuse it with
# the prefix that marks a parity error.  Therefore, a valid
# byte \377 is passed to the program as two bytes, \377
# \377, in this case.

# If neither IGNPAR nor PARMRK is set, read a character with
# a parity error or framing error as \0.

alias PARMRK = 3
alias INPCK = 16  # Enable input parity checking.
alias ISTRIP = 32  # Strip off eighth bit.

# alias INLCR  Translate NL to CR on input.

# alias IGNCR  Ignore carriage return on input.

# alias ICRNL  Translate carriage return to newline on input (unless
#         IGNCR is set).

# alias IUCLC  (not in POSIX) Map uppercase characters to lowercase on
#         input.

alias IXON = 512  # Enable XON/XOFF flow control on output.
alias IXANY = 2048  # (XSI) Typing any character will restart stopped output. (The default is to allow just the START character to restart output.)
alias IXOFF = 1024  # Enable XON/XOFF flow control on input.

# alias IMAXBEL
#         (not in POSIX) Ring bell when input queue is full.  Linux
#         does not implement this bit, and acts as if it is always
#         set.

# alias IUTF8 (since Linux 2.6.4)
#         (not in POSIX) Input is UTF8; this allows character-erase
#         to be correctly performed in cooked mode.

alias PARENB = 4096
alias CSIZE = 768
alias CS8 = 768
alias NOFLSH = 2147483648
alias TOSTOP = 4194304

# tty when values
alias TCSADRAIN = 1
alias TCSAFLUSH = 2
alias TCSANOW = 0
alias TCSASOFT = 16

# tty flow actions
alias TCOOFF = 1
alias TCOON = 2
alias TCOFLUSH = 2
alias TCIOFLUSH = 3


# define NCCS 12
@value
@register_passable("trivial")
struct Termios:
    var control_characters: StaticTuple[20, cc_t]  # control characters, c_cc
    var control_flags: tcflag_t  # control modes, control_flags
    var local_flags: tcflag_t  # local modes, c_lflag
    var input_flags: tcflag_t  # input modes, c_iflag
    var output_flags: tcflag_t  # output modes, c_oflag
    var input_speed: speed_t  # input baudrate, c_ispeed
    var output_speed: speed_t  # output baudrate, c_ospeed

    fn __init__(inout self):
        self.control_characters = StaticTuple[20, cc_t]()
        for i in range(len(self.control_characters)):
            self.control_characters[i] = 0
        self.control_flags = 0
        self.local_flags = 0
        self.input_flags = 0
        self.output_flags = 0
        self.input_speed = 0
        self.output_speed = 0


fn tcgetattr(fd: c_int, termios_p: Pointer[Termios]) -> c_int:
    """Libc POSIX `tcgetattr` function
    Reference: https://man7.org/linux/man-pages/man3/tcgetattr.3.html
    Fn signature: int tcgetattr(int fd, struct Termios *termios_p).

    Args:
        fd: File descriptor.
        termios_p: Pointer to a Termios struct.
    """
    return external_call["tcgetattr", c_int, c_int, Pointer[Termios]](fd, termios_p)


fn tcsetattr(fd: c_int, optional_actions: c_int, termios_p: Pointer[Termios]) -> c_int:
    """Libc POSIX `tcsetattr` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcsetattr(int fd, int optional_actions, const struct Termios *termios_p).

    Args:
        fd: File descriptor.
        optional_actions: Optional actions.
        termios_p: Pointer to a Termios struct.
    """
    return external_call["tcsetattr", c_int, c_int, c_int, Pointer[Termios]](
        fd, optional_actions, termios_p
    )


fn tcsendbreak(fd: c_int, duration: c_int) -> c_int:
    """Libc POSIX `tcsendbreak` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcsendbreak(int fd, int duration);.

    Args:
        fd: File descriptor.
        duration: Duration.
    """
    return external_call["tcsendbreak", c_int, c_int, c_int](fd, duration)


fn tcdrain(fd: c_int) -> c_int:
    """Libc POSIX `tcdrain` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcdrain(int fd).

    Args:
        fd: File descriptor.
    """
    return external_call["tcdrain", c_int, c_int](fd)


fn tcflush(fd: c_int, queue_selector: c_int) -> c_int:
    """Libc POSIX `tcflush` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcflush(int fd).

    Args:
        fd: File descriptor.
        queue_selector: Queue selector.
    """
    return external_call["tcflush", c_int, c_int](fd, queue_selector)


fn tcflow(fd: c_int, action: c_int) -> c_int:
    """Libc POSIX `tcflow` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcflow(int fd).

    Args:
        fd: File descriptor.
        action: Action.
    """
    return external_call["tcflow", c_int, c_int](fd, action)


fn cfmakeraw(termios_p: Pointer[Termios]) -> c_void:
    """Libc POSIX `cfmakeraw` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: void cfmakeraw(struct Termios *termios_p).

    Args:
        termios_p: Pointer to a Termios struct.
    """
    return external_call["cfmakeraw", c_void, Pointer[Termios]](termios_p)


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


# fn tcgetwinsize(fd: c_int, winsize_p: Pointer[winsize]) -> c_int:
#     """Libc POSIX `tcgetwinsize` function
#     Reference: https://man.netbsd.org/tcgetwinsize.3
#     Fn signature: int tcgetwinsize(int fd, struct winsize *gws).

#     Args:
#         fd: File descriptor.
#         winsize_p: Pointer to a winsize struct.
#     """
#     return external_call["tcgetwinsize", c_int, c_int, Pointer[winsize]](fd, winsize_p)


# fn tcsetwinsize(fd: c_int, winsize_p: Pointer[winsize]) -> c_int:
#     """Libc POSIX `tcgetwinsize` function
#     Reference: https://man.netbsd.org/tcsetwinsize.3
#     Fn signature: int tcsetwinsize(int fd, const struct winsize *sws).

#     Args:
#         fd: File descriptor.
#         winsize_p: Pointer to a winsize struct.
#     """
#     return external_call["tcsetwinsize", c_int, c_int, Pointer[winsize]](fd, winsize_p)

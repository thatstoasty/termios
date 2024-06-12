# C types
struct CType():
    alias void = UInt8
    alias char = UInt8
    alias schar = Int8
    alias uchar = UInt8
    alias short = Int16
    alias ushort = UInt16
    alias int = Int32
    alias uint = UInt32
    alias long = Int64
    alias ulong = UInt64
    alias float = Float32
    alias double = Float64
    alias size_t = Int
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
    alias CREAD = 2048
    alias CLOCAL = 32768
    alias PARENB = 4096
    alias CSIZE = 768

# local_flags values
struct LocalMode():
    alias ICANON = 256
    alias ECHO = 8
    alias ECHOE = 2
    alias ECHOK = 4
    alias ECHONL = 16
    alias ISIG = 128
    alias IEXTEN = 1024
    alias NOFLSH = 2147483648
    alias TOSTOP = 4194304


# output_flags values
struct OutputMode():
    alias OPOST = 1

# input_flags values
struct InputMode():
    alias INLCR = 64
    alias IGNCR = 128
    alias ICRNL = 256
    alias IGNBRK = 1  # Ignore BREAK condition on input.
    # If IGNBRK is set, a BREAK is ignored.  If it is not set
    # but BRKINT is set, then a BREAK causes the input and
    # output queues to be flushed, and if the terminal is the
    # controlling terminal of a foreground process group, it
    # will cause a SIGINT to be sent to this foreground process
    # group.  When neither IGNBRK nor BRKINT are set, a BREAK
    # reads as a null byte ('\0'), except when PARMRK is set, in
    # which case it reads as the sequence \377 \0 \0.
    alias BRKINT = 2
    alias IGNPAR = 4  # Ignore framing errors and parity errors.
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

    alias PARMRK = 8
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

struct ControlCharacter():
    # Special Character indexes for control_characters
    alias VEOF = 0  # Signal End-Of-Input	Ctrl-D
    alias VEOL = 1  # Signal End-Of-Line	[Disabled]
    alias VERASE = 3  # Delete previous character	Backspace
    alias VINTR = 8  # Generate SIGINT	Ctrl-C
    alias VKILL = 5  # 	Erase current line	Ctrl-U
    alias VMIN = 16  # 	The MIN value	1
    alias VQUIT = 9  # 	Generate SIGQUIT	Ctrl-\
    alias VSTART = 12  # 	Resume output	Ctrl-Q
    alias VSTOP = 13  # Suspend output	Ctrl-S
    alias VSUSP = 10  # Suspend program	Ctrl-Z
    alias VTIME = 17  # TIME value	0

alias CS8 = 768

# tty when values
struct TTYWhen():
    alias TCSADRAIN = 1
    alias TCSAFLUSH = 2
    alias TCSANOW = 0
    alias TCSASOFT = 16

# tty flow actions
struct TTYFlow():
    alias TCOOFF = 1
    alias TCOON = 2
    alias TCOFLUSH = 2
    alias TCIOFLUSH = 3


# define NCCS 12
@value
struct Termios():
    var input_flags: tcflag_t  # input modes, c_iflag
    var output_flags: tcflag_t  # output modes, c_oflag
    var control_flags: tcflag_t  # control modes, control_flags
    var local_flags: tcflag_t  # local modes, c_lflag
    var control_characters: InlineArray[CType.cc_t, 20]  # control characters, c_cc
    var input_speed: CType.speed_t  # input baudrate, c_ispeed
    var output_speed: CType.speed_t  # output baudrate, c_ospeed

    fn __init__(inout self):
        self.control_characters = InlineArray[CType.cc_t, 20](0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        self.control_flags = 0
        self.local_flags = 0
        self.input_flags = 0
        self.output_flags = 0
        self.input_speed = 0
        self.output_speed = 0



fn tcgetattr(fd: CType.int, termios_p: UnsafePointer[Termios]) -> CType.int:
    """Libc POSIX `tcgetattr` function
    Reference: https://man7.org/linux/man-pages/man3/tcgetattr.3.html
    Fn signature: int tcgetattr(int fd, struct Termios *termios_p).

    Args:
        fd: File descriptor.
        termios_p: Pointer to a Termios struct.
    """
    return external_call["tcgetattr", CType.int, CType.int, UnsafePointer[Termios]](fd, termios_p)


fn tcsetattr(fd: CType.int, optional_actions: CType.int, termios_p: UnsafePointer[Termios]) -> CType.int:
    """Libc POSIX `tcsetattr` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcsetattr(int fd, int optional_actions, const struct Termios *termios_p).

    Args:
        fd: File descriptor.
        optional_actions: Optional actions.
        termios_p: Pointer to a Termios struct.
    """
    return external_call["tcsetattr", CType.int, CType.int, CType.int, UnsafePointer[Termios]](
        fd, optional_actions, termios_p
    )


fn tcsendbreak(fd: CType.int, duration: CType.int) -> CType.int:
    """Libc POSIX `tcsendbreak` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcsendbreak(int fd, int duration);.

    Args:
        fd: File descriptor.
        duration: Duration.
    """
    return external_call["tcsendbreak", CType.int, CType.int, CType.int](fd, duration)


fn tcdrain(fd: CType.int) -> CType.int:
    """Libc POSIX `tcdrain` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcdrain(int fd).

    Args:
        fd: File descriptor.
    """
    return external_call["tcdrain", CType.int, CType.int](fd)


fn tcflush(fd: CType.int, queue_selector: CType.int) -> CType.int:
    """Libc POSIX `tcflush` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcflush(int fd).

    Args:
        fd: File descriptor.
        queue_selector: Queue selector.
    """
    return external_call["tcflush", CType.int, CType.int](fd, queue_selector)


fn tcflow(fd: CType.int, action: CType.int) -> CType.int:
    """Libc POSIX `tcflow` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: int tcflow(int fd).

    Args:
        fd: File descriptor.
        action: Action.
    """
    return external_call["tcflow", CType.int, CType.int](fd, action)


fn cfmakeraw[T: Termios](termios_p: UnsafePointer[Termios]) -> CType.void:
    """Libc POSIX `cfmakeraw` function
    Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
    Fn signature: void cfmakeraw(struct Termios *termios_p).

    Args:
        termios_p: Pointer to a Termios struct.
    """
    return external_call["cfmakeraw", CType.void, UnsafePointer[Termios]](termios_p)


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


# fn tcgetwinsize(fd: CType.int, winsize_p: UnsafePointer[winsize]) -> CType.int:
#     """Libc POSIX `tcgetwinsize` function
#     Reference: https://man.netbsd.org/tcgetwinsize.3
#     Fn signature: int tcgetwinsize(int fd, struct winsize *gws).

#     Args:
#         fd: File descriptor.
#         winsize_p: Pointer to a winsize struct.
#     """
#     return external_call["tcgetwinsize", CType.int, CType.int, UnsafePointer[winsize]](fd, winsize_p)


# fn tcsetwinsize(fd: CType.int, winsize_p: UnsafePointer[winsize]) -> CType.int:
#     """Libc POSIX `tcgetwinsize` function
#     Reference: https://man.netbsd.org/tcsetwinsize.3
#     Fn signature: int tcsetwinsize(int fd, const struct winsize *sws).

#     Args:
#         fd: File descriptor.
#         winsize_p: Pointer to a winsize struct.
#     """
#     return external_call["tcsetwinsize", CType.int, CType.int, UnsafePointer[winsize]](fd, winsize_p)

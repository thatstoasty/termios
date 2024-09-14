# # C types
# struct CType():
#     alias void = UInt8
#     alias char = UInt8
#     alias schar = Int8
#     alias uchar = UInt8
#     alias short = Int16
#     alias ushort = UInt16
#     alias int = Int32
#     alias uint = UInt32
#     alias long = Int64
#     alias ulong = UInt64
#     alias float = Float32
#     alias double = Float64
#     alias size_t = Int
#     alias ssize_t = Int
#     alias cc_t = UInt8
#     alias speed_t = UInt64
#     alias NCCS = Int8

# alias tcflag_t = UInt64

# # alias tcflag_t = UInt32
# # alias speed_t = UInt32
# # 64bit system


# struct FD():
#     alias FD_STDIN = 0
#     alias FD_STDOUT = 1
#     alias FD_STDERR = 2


# # control_flags values
# struct ControlMode():
#     alias CREAD = 128
#     alias CLOCAL = 2048
#     alias PARENB = 256
#     alias CSIZE = 48


# struct LocalMode():
#     alias ICANON = 2
#     alias ECHO = 8
#     alias ECHOE = 16
#     alias ECHOK = 32
#     alias ECHONL = 64
#     alias ISIG = 1
#     alias IEXTEN = 32768
#     alias NOFLSH = 128
#     alias TOSTOP = 256


# struct OutputMode():
#     alias OPOST = 1


# struct InputMode():
#     alias INLCR = 64
#     alias IGNCR = 128
#     alias ICRNL = 256
#     alias IGNBRK = 1
#     alias BRKINT = 2
#     alias IGNPAR = 4
#     alias PARMRK = 8
#     alias INPCK = 16
#     alias ISTRIP = 32
#     alias IXON = 1024
#     alias IXANY = 2048
#     alias IXOFF = 4096


# struct ControlCharacter():
#     alias VEOF = 4
#     alias VEOL = 11
#     alias VERASE = 2
#     alias VINTR = 0
#     alias VKILL = 3
#     alias VMIN = 6
#     alias VQUIT = 1
#     alias VSTART = 8
#     alias VSTOP = 9
#     alias VSUSP = 10
#     alias VTIME = 5


# alias CS8 = 48


# struct TTYWhen():
#     alias TCSADRAIN = 1
#     alias TCSAFLUSH = 2
#     alias TCSANOW = 0


# struct TTYFlow():
#     alias TCOOFF = 0
#     alias TCOON = 1
#     alias TCOFLUSH = 1
#     alias TCIOFLUSH = 2


# # define NCCS 12
# @value
# struct Termios():
#     var input_flags: tcflag_t  # input modes, c_iflag
#     var output_flags: tcflag_t  # output modes, c_oflag
#     var control_flags: tcflag_t  # control modes, control_flags
#     var local_flags: tcflag_t  # local modes, c_lflag
#     var control_characters: InlineArray[CType.cc_t, 20]  # control characters, c_cc
#     var input_speed: CType.speed_t  # input baudrate, c_ispeed
#     var output_speed: CType.speed_t  # output baudrate, c_ospeed

#     fn __init__(inout self):
#         self.control_characters = InlineArray[CType.cc_t, 20](0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
#         self.control_flags = 0
#         self.local_flags = 0
#         self.input_flags = 0
#         self.output_flags = 0
#         self.input_speed = 0
#         self.output_speed = 0



# fn tcgetattr(fd: CType.int, termios_p: UnsafePointer[Termios]) -> CType.int:
#     """Libc POSIX `tcgetattr` function
#     Reference: https://man7.org/linux/man-pages/man3/tcgetattr.3.html
#     Fn signature: int tcgetattr(int fd, struct Termios *termios_p).

#     Args:
#         fd: File descriptor.
#         termios_p: Pointer to a Termios struct.
#     """
#     return external_call["tcgetattr", CType.int, CType.int, UnsafePointer[Termios]](fd, termios_p)


# fn tcsetattr(fd: CType.int, optional_actions: CType.int, termios_p: UnsafePointer[Termios]) -> CType.int:
#     """Libc POSIX `tcsetattr` function
#     Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
#     Fn signature: int tcsetattr(int fd, int optional_actions, const struct Termios *termios_p).

#     Args:
#         fd: File descriptor.
#         optional_actions: Optional actions.
#         termios_p: Pointer to a Termios struct.
#     """
#     return external_call["tcsetattr", CType.int, CType.int, CType.int, UnsafePointer[Termios]](
#         fd, optional_actions, termios_p
#     )


# fn tcsendbreak(fd: CType.int, duration: CType.int) -> CType.int:
#     """Libc POSIX `tcsendbreak` function
#     Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
#     Fn signature: int tcsendbreak(int fd, int duration);.

#     Args:
#         fd: File descriptor.
#         duration: Duration.
#     """
#     return external_call["tcsendbreak", CType.int, CType.int, CType.int](fd, duration)


# fn tcdrain(fd: CType.int) -> CType.int:
#     """Libc POSIX `tcdrain` function
#     Reference: https://man7.org/linux/man-pages/man3/tcdrain.3.html
#     Fn signature: int tcdrain(int fd).

#     Args:
#         fd: File descriptor.
#     """
#     return external_call["tcdrain", CType.int, CType.int](fd)


# fn tcflush(fd: CType.int, queue_selector: CType.int) -> CType.int:
#     """Libc POSIX `tcflush` function
#     Reference: https://man7.org/linux/man-pages/man3/tcflush.3.html
#     Fn signature: int tcflush(int fd, int queue_selector);.

#     Args:
#         fd: File descriptor.
#         queue_selector: Queue selector.
#     """
#     return external_call["tcflush", CType.int, CType.int, CType.int](fd, queue_selector)


# fn tcflow(fd: CType.int, action: CType.int) -> CType.int:
#     """Libc POSIX `tcflow` function
#     Reference: https://man7.org/linux/man-pages/man3/tcflow.3.html
#     Fn signature: int tcflow(int fd, int action).

#     Args:
#         fd: File descriptor.
#         action: Action.
#     """
#     return external_call["tcflow", CType.int, CType.int, CType.int](fd, action)


# fn cfmakeraw[T: Termios](termios_p: UnsafePointer[Termios]) -> CType.void:
#     """Libc POSIX `cfmakeraw` function
#     Reference: https://man7.org/linux/man-pages/man3/tcsetattr.3.html
#     Fn signature: void cfmakeraw(struct Termios *termios_p).

#     Args:
#         termios_p: Pointer to a Termios struct.
#     """
#     return external_call["cfmakeraw", CType.void, UnsafePointer[Termios]](termios_p)


# # @value
# # @register_passable("trivial")
# # struct winsize():
# #     var ws_row: UInt8      # Number of rows, in characters */
# #     var ws_col: UInt8      # Number of columns, in characters */
# #     var ws_xpixel: UInt8   # Width, in pixels */
# #     var ws_ypixel: UInt8   # Height, in pixels */

# #     fn __init__(inout self):
# #         self.ws_row = 0
# #         self.ws_col = 0
# #         self.ws_xpixel = 0
# #         self.ws_ypixel = 0


# # fn tcgetwinsize(fd: CType.int, winsize_p: UnsafePointer[winsize]) -> CType.int:
# #     """Libc POSIX `tcgetwinsize` function
# #     Reference: https://man.netbsd.org/tcgetwinsize.3
# #     Fn signature: int tcgetwinsize(int fd, struct winsize *gws).

# #     Args:
# #         fd: File descriptor.
# #         winsize_p: Pointer to a winsize struct.
# #     """
# #     return external_call["tcgetwinsize", CType.int, CType.int, UnsafePointer[winsize]](fd, winsize_p)


# # fn tcsetwinsize(fd: CType.int, winsize_p: UnsafePointer[winsize]) -> CType.int:
# #     """Libc POSIX `tcgetwinsize` function
# #     Reference: https://man.netbsd.org/tcsetwinsize.3
# #     Fn signature: int tcsetwinsize(int fd, const struct winsize *sws).

# #     Args:
# #         fd: File descriptor.
# #         winsize_p: Pointer to a winsize struct.
# #     """
# #     return external_call["tcsetwinsize", CType.int, CType.int, UnsafePointer[winsize]](fd, winsize_p)

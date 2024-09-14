from termios import *
from socket import SO_RCVTIMEO
import sys

# control_flags values
print("struct ControlMode():")
print("    alias CREAD =", CREAD)
print("    alias CLOCAL =", CLOCAL)
print("    alias PARENB =", PARENB)
print("    alias CSIZE =", CSIZE)

# local_flags values
print("struct LocalMode():")
print("    alias ICANON =", ICANON)
print("    alias ECHO =", ECHO)
print("    alias ECHOE =", ECHOE)
print("    alias ECHOK =", ECHOK)
print("    alias ECHONL =", ECHONL)
print("    alias ISIG =", ISIG)
print("    alias IEXTEN =", IEXTEN)
print("    alias NOFLSH =", NOFLSH)
print("    alias TOSTOP =", TOSTOP)

# output_flags values
print("struct OutputMode():")
print("    alias OPOST =", OPOST)

# input_flags values
print("struct InputMode():")
print("    alias INLCR =", INLCR)
print("    alias IGNCR =", IGNCR)
print("    alias ICRNL =", ICRNL)
print("    alias IGNBRK =", IGNBRK)
print("    alias BRKINT =", BRKINT)
print("    alias IGNPAR =", IGNPAR)
print("    alias PARMRK =", PARMRK)
print("    alias INPCK =", INPCK)
print("    alias ISTRIP =", ISTRIP)
print("    alias IXON =", IXON)
print("    alias IXANY =", IXANY)
print("    alias IXOFF =", IXOFF)

# Control characters
print("struct ControlCharacter():")
print("    alias VEOF =", VEOF)  # Signal End-Of-Input	Ctrl-D
print("    alias VEOL =", VEOL)  # Signal End-Of-Line	[Disabled]
print("    alias VERASE =", VERASE)  # Delete previous character	Backspace
print("    alias VINTR =", VINTR)  # Generate SIGINT	Ctrl-C
print("    alias VKILL =", VKILL)  # 	Erase current line	Ctrl-U
print("    alias VMIN =", VMIN)  # 	The MIN value	1
print("    alias VQUIT =", VQUIT)  # 	Generate SIGQUIT	Ctrl-\
print("    alias VSTART =", VSTART)  # 	Resume output	Ctrl-Q
print("    alias VSTOP =", VSTOP)  # Suspend output	Ctrl-S
print("    alias VSUSP =", VSUSP)  # Suspend program	Ctrl-Z
print("    alias VTIME =", VTIME)  # TIME value	0

print("alias CS8 =", CS8)  # TIME value	0

# tty when values
print("struct TTYWhen():")
print("    alias TCSADRAIN =", TCSADRAIN)
print("    alias TCSAFLUSH =", TCSAFLUSH)
print("    alias TCSANOW =", TCSANOW)
# print("    alias TCSASOFT =", TCSASOFT)

# tty flow actions
print("struct TTYFlow():")
print("    alias TCOOFF =", TCOOFF)
print("    alias TCOON =", TCOON)
print("    alias TCOFLUSH =", TCOFLUSH)
print("    alias TCIOFLUSH =", TCIOFLUSH)

print(SO_RCVTIMEO)
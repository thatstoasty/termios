from termios import *
import sys

# print("ICANON", ICANON)

# # c_cflag values
# print(CREAD)
# print(CLOCAL)

# # c_lflag values
# print(ICANON)
# print(ECHO)
# print(ECHOE)
# print(ECHOK)
# print(ECHONL)
# print(ISIG)
# print(IEXTEN)

# # c_oflag values
# print(OPOST)

# # c_iflag values
# print(INLCR)
# print(IGNCR)
# print(ICRNL)
# print(IGNBRK) # Ignore BREAK condition on input.

print("[iflag, oflag, cflag, lflag, ispeed, ospeed, cc]")
print(tcgetattr(1))

# print("alias IGNBRK =", IGNBRK)
# print("alias BRKINT =", BRKINT)
# print("alias IGNPAR =", IGNPAR)
# print("alias PARMRK =", PARMRK)
# print("alias INPCK =", INPCK)
# print("alias ISTRIP =", ISTRIP)
# print("alias INLCR =", INLCR)
# print("alias IGNCR =", IGNCR)
# print("alias ICRNL =", ICRNL)
# print("alias IXON =", IXON)
# print("alias IXANY =", IXANY)
# print("alias IXOFF =", IXOFF)
# print("alias OPOST =", OPOST)
# print("alias PARENB =", PARENB)
# print("alias CSIZE =", CSIZE)

# print("alias ECHO =", ECHO)
# print("alias ECHOE =", ECHOE)
# print("alias ECHOK =", ECHOK)
# print("alias ECHONL =", ECHONL)
# print("alias ICANON =", ICANON)
# print("alias IEXTEN =", IEXTEN)
# print("alias ISIG =", ISIG)
# print("alias NOFLSH =", NOFLSH)
# print("alias TOSTOP =", TOSTOP)
# print("alias IXON =", IXON)
# print("alias IXANY =", IXANY)
# print("alias IXOFF =", IXOFF)
# print("alias OPOST =", OPOST)
# print("alias PARENB =", PARENB)
# print("alias CSIZE =", CSIZE)

print("alias VEOF =", VEOF)  # Signal End-Of-Input	Ctrl-D
print("alias VEOL =", VEOL)  # Signal End-Of-Line	[Disabled]
print("alias VERASE =", VERASE)  # Delete previous character	Backspace
print("alias VINTR =", VINTR)  # Generate SIGINT	Ctrl-C
print("alias VKILL =", VKILL)  # 	Erase current line	Ctrl-U
print("alias VMIN =", VMIN)  # 	The MIN value	1
print("alias VQUIT =", VQUIT)  # 	Generate SIGQUIT	Ctrl-\
print("alias VSTART =", VSTART)  # 	Resume output	Ctrl-Q
print("alias VSTOP =", VSTOP)  # Suspend output	Ctrl-S
print("alias VSUSP =", VSUSP)  # Suspend program	Ctrl-Z
print("alias VTIME =", VTIME)  # TIME value	0



# print(TCSADRAIN)
# print(TCSAFLUSH)
# print(TCSANOW)
# print(TCSASOFT)
# print(TCSBRK)
# print(TCSBRKP)
# print(TCSETA)
# print(TCSETAF)
# print(TCSETAW)
# print(TCSETS)
# print(TCSETSF)
# print(TCSETSW)
# print(INPCK)
# print(ISTRIP)
# print(IXON)
# print(IXANY)
# print(IXOFF)
# print(PARENB)
# print(CSIZE)
# print(CS8)
# print(NOFLSH)
# print(TOSTOP)

# print(TCIFLUSH)
# print(TCOON)
# print(TCOFLUSH)
# print(TCIOFLUSH)
# sys.stdin.read()
# sys.stdin.fileno()
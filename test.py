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
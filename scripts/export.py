from termios import *
from socket import SO_RCVTIMEO
import select
import selectors
# from select import POLLIN, POLLOUT, EPOLLRDHUP, POLLPRI, POLLERR, POLLHUP, EPOLLET, EPOLLONESHOT, EPOLLEXCLUSIVE
import sys

print("alias EPOLLIN =", select.POLLIN)
print("alias EPOLLOUT =", select.POLLOUT)
# print("alias EPOLLRDHUP =", select.EPOLLRDHUP)
print("alias EPOLLPRI =", select.POLLPRI)
print("alias EPOLLERR =", select.POLLERR)
print("alias EPOLLHUP =", select.POLLHUP)
# print("alias EPOLLET =", select.EPOLLET)
# print("alias EPOLLONESHOT =", select.EPOLLONESHOT)
# print("alias EPOLLEXCLUSIVE =", select.EPOLLEXCLUSIVE)

print("alias EPOLLPRI =", select.POLLPRI)
print("alias EPOLLERR =", select.POLLERR)
print("alias EPOLLHUP =", select.POLLHUP)

print("alias KQ_EV_ADD =", select.KQ_EV_ADD)
print("alias KQ_EV_CLEAR =", select.KQ_EV_CLEAR)
print("alias KQ_EV_DELETE =", select.KQ_EV_DELETE)
print("alias KQ_EV_DISABLE =", select.KQ_EV_DISABLE)
print("alias KQ_EV_ENABLE =", select.KQ_EV_ENABLE)
print("alias KQ_EV_EOF =", select.KQ_EV_EOF)
print("alias KQ_EV_ERROR =", select.KQ_EV_ERROR)
print("alias KQ_EV_FLAG1 =", select.KQ_EV_FLAG1)
print("alias KQ_EV_ONESHOT =", select.KQ_EV_ONESHOT)
print("alias KQ_EV_SYSFLAGS =", select.KQ_EV_SYSFLAGS)
print("alias KQ_FILTER_AIO =", select.KQ_FILTER_AIO)
# print("alias KQ_FILTER_NETDEV =", select.KQ_FILTER_NETDEV)
print("alias KQ_FILTER_PROC =", select.KQ_FILTER_PROC)
print("alias KQ_FILTER_READ =", select.KQ_FILTER_READ)
print("alias KQ_FILTER_SIGNAL =", select.KQ_FILTER_SIGNAL)
print("alias KQ_FILTER_TIMER =", select.KQ_FILTER_TIMER)
print("alias KQ_FILTER_VNODE =", select.KQ_FILTER_VNODE)
print("alias KQ_FILTER_WRITE =", select.KQ_FILTER_WRITE)
print("alias KQ_NOTE_ATTRIB =", select.KQ_NOTE_ATTRIB)
print("alias KQ_NOTE_CHILD =", select.KQ_NOTE_CHILD)
print("alias KQ_NOTE_DELETE =", select.KQ_NOTE_DELETE)
print("alias KQ_NOTE_EXEC =", select.KQ_NOTE_EXEC)
print("alias KQ_NOTE_EXIT =", select.KQ_NOTE_EXIT)
print("alias KQ_NOTE_EXTEND =", select.KQ_NOTE_EXTEND)
print("alias KQ_NOTE_FORK =", select.KQ_NOTE_FORK)
print("alias KQ_NOTE_LINK =", select.KQ_NOTE_LINK)
print("alias KQ_NOTE_LOWAT =", select.KQ_NOTE_LOWAT)
print("alias KQ_NOTE_PCTRLMASK =", select.KQ_NOTE_PCTRLMASK)
print("alias KQ_NOTE_PDATAMASK =", select.KQ_NOTE_PDATAMASK)
print("alias KQ_NOTE_RENAME =", select.KQ_NOTE_RENAME)
print("alias KQ_NOTE_REVOKE =", select.KQ_NOTE_REVOKE)
print("alias KQ_NOTE_TRACK =", select.KQ_NOTE_TRACK)
print("alias KQ_NOTE_TRACKERR =", select.KQ_NOTE_TRACKERR)
print("alias KQ_NOTE_WRITE =", select.KQ_NOTE_WRITE)

# # control_flags values
# print("struct ControlMode():")
# print("    alias CREAD =", CREAD)
# print("    alias CLOCAL =", CLOCAL)
# print("    alias PARENB =", PARENB)
# print("    alias CSIZE =", CSIZE)

# # local_flags values
# print("struct LocalMode():")
# print("    alias ICANON =", ICANON)
# print("    alias ECHO =", ECHO)
# print("    alias ECHOE =", ECHOE)
# print("    alias ECHOK =", ECHOK)
# print("    alias ECHONL =", ECHONL)
# print("    alias ISIG =", ISIG)
# print("    alias IEXTEN =", IEXTEN)
# print("    alias NOFLSH =", NOFLSH)
# print("    alias TOSTOP =", TOSTOP)

# # output_flags values
# print("struct OutputMode():")
# print("    alias OPOST =", OPOST)

# # input_flags values
# print("struct InputMode():")
# print("    alias INLCR =", INLCR)
# print("    alias IGNCR =", IGNCR)
# print("    alias ICRNL =", ICRNL)
# print("    alias IGNBRK =", IGNBRK)
# print("    alias BRKINT =", BRKINT)
# print("    alias IGNPAR =", IGNPAR)
# print("    alias PARMRK =", PARMRK)
# print("    alias INPCK =", INPCK)
# print("    alias ISTRIP =", ISTRIP)
# print("    alias IXON =", IXON)
# print("    alias IXANY =", IXANY)
# print("    alias IXOFF =", IXOFF)

# # Control characters
# print("struct ControlCharacter():")
# print("    alias VEOF =", VEOF)  # Signal End-Of-Input	Ctrl-D
# print("    alias VEOL =", VEOL)  # Signal End-Of-Line	[Disabled]
# print("    alias VERASE =", VERASE)  # Delete previous character	Backspace
# print("    alias VINTR =", VINTR)  # Generate SIGINT	Ctrl-C
# print("    alias VKILL =", VKILL)  # 	Erase current line	Ctrl-U
# print("    alias VMIN =", VMIN)  # 	The MIN value	1
# print("    alias VQUIT =", VQUIT)  # 	Generate SIGQUIT	Ctrl-\
# print("    alias VSTART =", VSTART)  # 	Resume output	Ctrl-Q
# print("    alias VSTOP =", VSTOP)  # Suspend output	Ctrl-S
# print("    alias VSUSP =", VSUSP)  # Suspend program	Ctrl-Z
# print("    alias VTIME =", VTIME)  # TIME value	0

# print("alias CS8 =", CS8)  # TIME value	0

# # tty when values
# print("struct TTYWhen():")
# print("    alias TCSADRAIN =", TCSADRAIN)
# print("    alias TCSAFLUSH =", TCSAFLUSH)
# print("    alias TCSANOW =", TCSANOW)
# # print("    alias TCSASOFT =", TCSASOFT)

# # tty flow actions
# print("struct TTYFlow():")
# print("    alias TCOOFF =", TCOOFF)
# print("    alias TCOON =", TCOON)
# print("    alias TCOFLUSH =", TCOFLUSH)
# print("    alias TCIOFLUSH =", TCIOFLUSH)

# print(SO_RCVTIMEO)

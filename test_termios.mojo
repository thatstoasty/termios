from termios.c.terminal import tcgetattr, tcsetattr, tcdrain, FD_STDIN, cc_t, termios, IGNBRK, OPOST, CREAD, ECHO, TCSADRAIN, TCSANOW
from termios.c.syscalls import read_string_from_fd, read_bytes_from_fd
from termios.terminal import tc_get_attr, tc_set_attr
from termios.tty import cfmakeraw, setraw, setcbreak


fn getpass(prompt: String = "Password: ") raises -> String:
    var fd = int(FD_STDIN)
    var old_settings = tc_get_attr(FD_STDIN)
    var new_settings = tc_get_attr(FD_STDIN)
    new_settings.c_lflag = new_settings.c_lflag & ~ECHO # 
    var passwd: String = ""
    try:
        print(prompt)
        _ = tc_set_attr(fd, TCSADRAIN, Pointer.address_of(new_settings))
        # passwd = input(prompt)
        with open("/dev/stdin", "r") as stdin:
            var bytes = stdin.read_bytes(1)
            passwd = chr(int(bytes[0]))
    finally:
        _ = tc_set_attr(fd, TCSADRAIN, Pointer.address_of(old_settings))
    return passwd


fn get_key_unix() raises -> String:
    var old_settings = tc_get_attr(FD_STDIN)
    print(old_settings.c_cflag, old_settings.c_iflag, old_settings.c_lflag, old_settings.c_oflag, old_settings.c_ispeed, old_settings.c_ospeed)
    var status = setraw(int(FD_STDIN))

    var key: String = ""
    with open("/dev/stdin", "r") as stdin:
        var bytes = stdin.read_bytes(1)
        key = chr(int(bytes[0]))
    
    # var bytes = read_bytes_from_fd(FD_STDIN, 1)
    # key = chr(int(bytes[0]))
    # key = read_string_from_fd(FD_STDIN, 1)

    # restore terminal settings
    var setattr_result = tc_set_attr(FD_STDIN, TCSADRAIN, Pointer.address_of(old_settings))
    return key


fn get_key() raises -> String:
    var k: String = ""

    while True:
        k = get_key_unix()
        print("k is", k)
        if k == 'c':
            break
        
        print(k)

    return k


fn main() raises:
    print(getpass())
    # var old_settings = setcbreak(int(FD_STDIN), TCSANOW)
    # _ = get_key()
    # _ = tc_set_attr(FD_STDIN, TCSADRAIN, Pointer.address_of(old_settings))
    # _ = get_key()
    # var cc = StaticTuple[20, UInt8]()
    # for i in range(len(cc)):
    #     cc[i] = 0
    # var termios_p = termios(
    #     c_iflag = 0,
    #     c_oflag = 0,
    #     c_cflag = 0,
    #     c_lflag = 0,
    #     c_ispeed = 0,
    #     c_ospeed = 0,
    #     c_cc = cc
    # )
    # var status = tcdrain(FD_STDOUT)
    # print(status)
    # var old_settings = tc_get_attr(FD_STDIN)
    
    # # print("Control flags", termios_p.c_cflag)
    # # print("Input flags", termios_p.c_iflag)
    # # print("Local flags", termios_p.c_lflag)
    # # print("Output flags", termios_p.c_oflag)
    # # print("Input Speed", termios_p.c_ispeed)
    # # print("Output Speed", termios_p.c_ospeed)
    # # # for i in range(len(termios_p.c_cc)):
    # # #     print("cc", i, termios_p.c_cc[i])

    # # cfmakeraw(termios_p)
    # # print("after cfmakeraw")
    # # print("Control flags", termios_p.c_cflag)
    # # print("Input flags", termios_p.c_iflag)
    # # print("Local flags", termios_p.c_lflag)
    # # print("Output flags", termios_p.c_oflag)
    # # print("Input Speed", termios_p.c_ispeed)
    # # print("Output Speed", termios_p.c_ospeed)

    # var status = setraw(int(FD_STDIN))

    # with open("/dev/stdin", "r") as stdin:
    #     print("waiting for input")
    #     var bytes = stdin.read_bytes(1)
    #     var key = chr(int(bytes[0]))

    #     if key == "k":
    #         print("You pressed k!")
    #     else:
    #         print("You didn't press k :(")
    # # restore terminal settings
    # var setattr_result = tc_set_attr(FD_STDIN, TCSADRAIN, Pointer.address_of(old_settings))
    # [iflag, oflag, cflag, lflag, ispeed, ospeed, cc]
    # [27394, 3, 19200, 536872399, 38400, 38400, [b'\x04', b'\xff', b'\xff', b'\x7f', b'\x17', b'\x15', b'\x12', b'\x00', b'\x03', b'\x1c', b'\x1a', b'\x19', b'\x11', b'\x13', b'\x16', b'\x0f', b'\x01', b'\x00', b'\x14', b'\x00']]

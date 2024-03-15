from termios.c.terminal import tcgetattr, tcsetattr, tcdrain, FD_STDIN, cc_t, termios, IGNBRK, OPOST, CREAD, ECHO, TCSADRAIN
from termios.terminal import tc_get_attr, tc_set_attr
from termios.tty import cfmakeraw, setraw


fn get_key_unix() raises -> String:
    var old_settings = tc_get_attr(FD_STDIN)
    var status = setraw(int(FD_STDIN))

    var key: String = ""
    with open("/dev/stdin", "r") as stdin:
        var bytes = stdin.read_bytes(1)
        key = chr(int(bytes[0]))

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
    _ = get_key()
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

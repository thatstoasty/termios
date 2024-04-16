from termios.c.terminal import tcgetattr, tcsetattr, tcdrain, FD_STDIN, cc_t, Termios, IGNBRK, OPOST, CREAD, ECHO, TCSADRAIN, TCSANOW
from termios.c.syscalls import read_string_from_fd, read_bytes_from_fd, read_from_stdin
from termios.terminal import get_tty_attributes, set_tty_attributes
from termios.tty import set_control_flags_to_raw_mode, set_tty_to_raw, set_tty_to_cbreak
from time import now
from python import Python


# fn get_password(prompt: String = "Password: ") raises -> String:
#     var fd = int(FD_STDIN)
#     var old_settings = get_tty_attributes(FD_STDIN)
#     var new_settings = get_tty_attributes(FD_STDIN)

#     # Turn off echo
#     new_settings.local_flags = new_settings.local_flags & ~ECHO
#     var passwd: String = ""
#     try:
#         print(prompt)
#         _ = set_tty_attributes(fd, TCSADRAIN, Pointer.address_of(new_settings))
#         with open("/dev/stdin", "r") as stdin:
#             passwd = read_from_stdin()
#             # var bytes = stdin.read_bytes(1)
#             # passwd = chr(int(bytes[0]))
#     except:
#         raise
#     finally:
#         _ = set_tty_attributes(fd, TCSADRAIN, Pointer.address_of(old_settings))
#     return passwd


fn get_key_unix() raises -> String:
    var old_settings = get_tty_attributes(FD_STDIN)
    var status = set_tty_to_raw(int(FD_STDIN))

    var key: String = ""
    with open("/dev/stdin", "r") as stdin:
        var bytes = stdin.read_bytes(1)
        key = chr(int(bytes[0]))
        # print("key is", key)

    # restore terminal settings
    var ptr = Pointer.address_of(old_settings)
    var setattr_result = set_tty_attributes(FD_STDIN, TCSADRAIN, ptr)
    # print(setattr_result)
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


fn join(separator: String, iterable: List[String]) raises -> String:
    var result: String = ""
    for i in range(iterable.__len__()):
        result += iterable[i]
        if i != iterable.__len__() - 1:
            result += separator
    return result


fn test_ui() raises -> String:
    var start = now()
    # print("starting", (start - now()))
    var k: String = ""

    var cursor_index = 0
    var options = List[String]("Option 1", "Option 2", "Option 3")

    var view = String("> ") + options[0] + "\n" + options[1] + "\n" + options[2] + "\n"
    
    var old_settings = get_tty_attributes(FD_STDIN)
    var tty = Python.import_module("tty")
    var sys = Python.import_module("sys")
    var raw_result = tty.setraw(
        sys.stdin.fileno()
    )  # set to variable to stop compiler warning
    # TODO: set_tty_to_raw is the thing slowing this down
    # var status = set_tty_to_raw(int(FD_STDIN))
    # print("terminal is raw", (start - now()))      
    # k = read_from_stdin()  
    # with open("/dev/tty", "r") as stdin:
    while True:
        print(view)
        # print("reading from stdin", (start - now()))
        k = read_from_stdin()
        # var bytes = stdin.read_bytes(1)
        # k = chr(int(bytes[0]))
        # k = read_from_stdin()
        # print("read from stdin", k, (start - now()))

        # restore terminal settings
        # print("k is", k)
        if k == "c":
            break
        
    var ptr = Pointer.address_of(old_settings)
    var setattr_result = set_tty_attributes(FD_STDIN, TCSADRAIN, ptr)
    print(setattr_result, (start - now()))

    return k


fn main() raises:
    print(test_ui())
    # print(get_password())
    # var old_settings = setcbreak(int(FD_STDIN), TCSANOW)
    # _ = get_key()
    # _ = set_tty_attributes(FD_STDIN, TCSADRAIN, Pointer.address_of(old_settings))
    # _ = get_key()
    # var cc = StaticTuple[20, UInt8]()
    # for i in range(len(cc)):
    #     cc[i] = 0
    # var Termios_p = Termios(
    #     input_flags = 0,
    #     output_flags = 0,
    #     control_flags = 0,
    #     local_flags = 0,
    #     input_speed = 0,
    #     output_speed = 0,
    #     control_characters = cc
    # )
    # var status = tcdrain(FD_STDOUT)
    # print(status)
    # var old_settings = get_tty_attributes(FD_STDIN)
    
    # # print("Control flags", Termios_p.control_flags)
    # # print("Input flags", Termios_p.input_flags)
    # # print("Local flags", Termios_p.local_flags)
    # # print("Output flags", Termios_p.output_flags)
    # # print("Input Speed", Termios_p.input_speed)
    # # print("Output Speed", Termios_p.output_speed)
    # # # for i in range(len(Termios_p.control_characters)):
    # # #     print("cc", i, Termios_p.control_characters[i])

    # # cfmakeraw(Termios_p)
    # # print("after cfmakeraw")
    # # print("Control flags", Termios_p.control_flags)
    # # print("Input flags", Termios_p.input_flags)
    # # print("Local flags", Termios_p.local_flags)
    # # print("Output flags", Termios_p.output_flags)
    # # print("Input Speed", Termios_p.input_speed)
    # # print("Output Speed", Termios_p.output_speed)

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
    # var setattr_result = set_tty_attributes(FD_STDIN, TCSADRAIN, Pointer.address_of(old_settings))
    # [iflag, oflag, cflag, lflag, ispeed, ospeed, cc]
    # [27394, 3, 19200, 536872399, 38400, 38400, [b'\x04', b'\xff', b'\xff', b'\x7f', b'\x17', b'\x15', b'\x12', b'\x00', b'\x03', b'\x1c', b'\x1a', b'\x19', b'\x11', b'\x13', b'\x16', b'\x0f', b'\x01', b'\x00', b'\x14', b'\x00']]

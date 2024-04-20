from termios.c.terminal import tcgetattr, tcsetattr, tcdrain, FD_STDIN, cc_t, Termios, IGNBRK, OPOST, CREAD, ECHO, TCSADRAIN, TCSANOW
from termios.c.syscalls import read_string_from_fd, read_bytes_from_fd, read_from_stdin
from termios.terminal import get_tty_attributes, set_tty_attributes
from termios.tty import set_control_flags_to_raw_mode, set_tty_to_raw, set_tty_to_cbreak


fn get_key_unix() raises -> String:
    var old_settings = get_tty_attributes(FD_STDIN)
    var status = set_tty_to_raw(int(FD_STDIN))

    var key: String = ""
    with open("/dev/stdin", "r") as stdin:
        var bytes = stdin.read_bytes(1)
        key = chr(int(bytes[0]))

    # restore terminal settings
    var ptr = Pointer.address_of(old_settings)
    var setattr_result = set_tty_attributes(FD_STDIN, TCSADRAIN, ptr)
    return key


fn get_key() raises -> String:
    print("Press c to exit.")
    var k: String = ""

    while True:
        k = get_key_unix()
        if k == 'c':
            break
        
        print(k)

    return k


fn main() raises:
    print(get_key())
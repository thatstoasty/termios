from termios.mac.c import FD, TTYWhen, Termios
from termios.mac.terminal import get_tty_attributes, set_tty_attributes
from termios.mac.tty import set_control_flags_to_raw_mode, set_tty_to_raw, set_tty_to_cbreak
# from termios.linux.c import FD, TTYWhen, Termios
# from termios.linux.terminal import get_tty_attributes, set_tty_attributes
# from termios.linux.tty import set_control_flags_to_raw_mode, set_tty_to_raw, set_tty_to_cbreak


fn get_key_unix() raises -> String:
    var key: String = ""
    with open("/dev/tty", "r") as stdin:
        var bytes = stdin.read_bytes(1)
        key = chr(int(bytes[0]))

    return key


fn get_key() raises -> String:
    print("Press c to exit.")
    var k: String = ""
    var old_settings = get_tty_attributes(FD.FD_STDIN)
    _ = set_tty_to_raw(FD.FD_STDIN)

    while True:
        k = get_key_unix()
        if k == 'c':
            break

    # restore terminal settings
    set_tty_attributes(FD.FD_STDIN, TTYWhen.TCSADRAIN, old_settings)  
    print(k)

    return k


fn main() raises:
    print(get_key())
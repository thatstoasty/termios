# Termios
Mojo Termios via `libc`. This is only tested on Mac and will most likely have issues with the `Termios` struct on linux. It does not work on Ubuntu 22.04 as of now, so you'll need to update the `Termios` struct as needed if running on Linux. You would most likely need to change the order of the fields in the struct. If that doesn't work, then the values of the constants may need to be updated too.

Will add more later. Here's a basic example from the examples directory.

```mojo
from termios.c import FD_STDIN, TCSADRAIN, Termios
from termios.terminal import get_tty_attributes, set_tty_attributes
from termios.tty import set_control_flags_to_raw_mode, set_tty_to_raw, set_tty_to_cbreak


fn get_key_unix() raises -> String:
    var old_settings: Termios
    var err: Error
    old_settings, err = get_tty_attributes(FD_STDIN)
    if err:
        raise err

    var throwaway: Termios
    throwaway, err = set_tty_to_raw(FD_STDIN)
    if err:
        raise err

    var key: String = ""
    with open("/dev/stdin", "r") as stdin:
        var bytes = stdin.read_bytes(1)
        key = chr(int(bytes[0]))

    # restore terminal settings
    var status: Int32
    status, err = set_tty_attributes(FD_STDIN, TCSADRAIN, UnsafePointer(old_settings))
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
```

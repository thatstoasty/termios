# Termios

Mojo Termios via `libc`. This is only tested on Mac and will most likely have issues with the `Termios` struct on linux. It does not work on Ubuntu 22.04 as of now, so you'll need to update the `Termios` struct as needed if running on Linux. You would most likely need to change the order of the fields in the struct. If that doesn't work, then the values of the constants may need to be updated too.

Will add more later. Here's a basic example from the examples directory.

```mojo
import termios
from termios import Termios, tcsetattr, tcgetattr, set_raw, STDIN


fn get_key_unix() raises -> String:
    var key: String = ""
    with open("/dev/tty", "r") as stdin:
        var bytes = stdin.read_bytes(1)
        key = chr(int(bytes[0]))

    return key


fn get_key() raises -> String:
    print("Press c to exit.")
    var k: String = ""
    var old_settings = tcgetattr(STDIN)
    _ = set_raw(STDIN)

    while True:
        k = get_key_unix()
        if k == 'c':
            break

    # restore terminal settings
    tcsetattr(STDIN, termios.TCSADRAIN, old_settings)
    print(k)

    return k


fn main() raises:
    print(get_key())

```

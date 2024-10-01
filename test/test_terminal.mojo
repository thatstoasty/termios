from termios import get_tty_attributes, Termios, FD
import testing


def test_get_tty_attributes():
    testing.assert_equal(str(get_tty_attributes(FD.FD_STDIN)), str(Termios()))

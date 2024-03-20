from .terminal import c_int, c_char, c_ssize_t, c_size_t

alias char_pointer = AnyPointer[c_char]

@value
struct Str:
    var vector: DynamicVector[c_char]

    fn __init__(inout self, string: String):
        self.vector = DynamicVector[c_char](capacity=len(string) + 1)
        for i in range(len(string)):
            self.vector.push_back(ord(string[i]))
        self.vector.push_back(0)

    fn __init__(inout self, size: Int):
        self.vector = DynamicVector[c_char]()
        self.vector.resize(size + 1, 0)

    fn __len__(self) -> Int:
        for i in range(len(self.vector)):
            if self.vector[i] == 0:
                return i
        return -1

    fn to_string(self, size: Int) -> String:
        var result: String = ""
        for i in range(size):
            result += chr(self.vector[i].to_int())
        return result

    fn __enter__(owned self: Self) -> Self:
        return self ^

fn read_string_from_fd(file_descriptor: c_int, size: Int = 4096) raises -> String:
    var buffer: Str
    with Str(size=size) as buffer:
        var read_count: c_ssize_t = external_call[
            "read", c_ssize_t, c_int, char_pointer, c_size_t
        ](file_descriptor, buffer.vector.data, size)
        if read_count == -1:
            raise Error("Failed to read file descriptor" + String(file_descriptor))

        # for stdin, stdout, stderr, we can do this approximation
        # normally we would decode to utf-8 as we go and check for \n, but we can't do that now because
        # we don't have easy to use utf-8 support.
        if read_count == size:
            return buffer.to_string(read_count)
        
        raise Error(
                "You can only read up to "
                + String(size)
                + " bytes. "
                "Wait for UTF-8 support in Mojo for better handling of long inputs."
            )


fn read_bytes_from_fd(file_descriptor: c_int, size: Int = 4096) raises -> DynamicVector[c_char]:
    with Str(size=size) as buffer:
        var read_count: c_ssize_t = external_call[
            "read", c_ssize_t, c_int, char_pointer, c_size_t
        ](file_descriptor, buffer.vector.data, size)
        if read_count == -1:
            raise Error("Failed to read file descriptor" + String(file_descriptor))

        # for stdin, stdout, stderr, we can do this approximation
        # normally we would decode to utf-8 as we go and check for \n, but we can't do that now because
        # we don't have easy to use utf-8 support.
        if read_count == size:
            raise Error(
                "You can only read up to "
                + String(size)
                + " bytes. "
                "Wait for UTF-8 support in Mojo for better handling of long inputs."
            )

        return buffer.vector
from .terminal import c_int, c_char, c_ssize_t, c_size_t, FD_STDIN
from time import now

alias char_pointer = AnyPointer[c_char]
alias FILE = UInt64


@value
struct Str:
    var vector: List[c_char]

    fn __init__(inout self, string: String):
        self.vector = List[c_char](capacity=len(string) + 1)
        for i in range(len(string)):
            self.vector.append(ord(string[i]))
        self.vector.append(0)

    fn __init__(inout self, size: Int):
        self.vector = List[c_char]()
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


fn to_char_ptr(s: String) -> Pointer[c_char]:
    """Only ASCII-based strings."""
    var ptr = Pointer[c_char]().alloc(len(s) + 1)
    for i in range(len(s)):
        ptr.store(i, ord(s[i]))
    ptr.store(len(s), ord("\0"))
    return ptr


fn fread(
    __ptr: Pointer[UInt8], __size: UInt64, __nitems: UInt64, __stream: Pointer[UInt64]
) -> UInt64:
    return external_call[
        "fread", UInt64, Pointer[UInt8], UInt64, UInt64, Pointer[UInt64]
    ](__ptr, __size, __nitems, __stream)


fn fopen(__filename: Pointer[UInt8], __mode: Pointer[UInt8]) -> Pointer[FILE]:
    return external_call["fopen", Pointer[FILE], Pointer[UInt8], Pointer[UInt8]](
        __filename, __mode
    )


fn fgetc(arg: Pointer[FILE]) -> Int32:
    return external_call["fgetc", Int32, Pointer[FILE]](arg)


fn clearerr(arg: Pointer[FILE]) -> UInt8:
    return external_call["clearerr", UInt8, Pointer[FILE]](arg)


fn fclose(arg: Pointer[FILE]) -> Int32:
    return external_call["fclose", Int32, Pointer[FILE]](arg)


fn feof(arg: Pointer[FILE]) -> Int32:
    return external_call["feof", Int32, Pointer[FILE]](arg)


fn ferror(arg: Pointer[FILE]) -> Int32:
    return external_call["ferror", Int32, Pointer[FILE]](arg)


fn read_string_from_fd(file_descriptor: Int32) raises -> String:
    alias buffer_size: Int = 2**13
    var buffer: Str
    with Str(size=buffer_size) as buffer:
        var read_count: c_ssize_t = external_call[
            "read", c_ssize_t, Int32, char_pointer, c_size_t
        ](file_descriptor, buffer.vector.data, buffer_size)
        if read_count == -1:
            raise Error("Failed to read file descriptor" + String(file_descriptor))

        # for stdin, stdout, stderr, we can do this approximation
        # normally we would decode to utf-8 as we go and check for \n, but we can't do that now because
        # we don't have easy to use utf-8 support.
        if read_count == buffer_size:
            raise Error(
                "You can only read up to "
                + String(buffer_size)
                + " bytes. "
                "Wait for UTF-8 support in Mojo for better handling of long inputs."
            )

        return buffer.to_string(read_count)


fn read_from_stdin() raises -> String:
    return read_string_from_fd(FD_STDIN)


fn read_string_from_fd(inout file_descriptor: UInt64) raises -> String:
    var start = now()
    alias buffer_size: Int = 4096
    var buffer: Str
    var fd = fopen(to_char_ptr("/dev/tty"), to_char_ptr("r"))
    # print(status.load())
    # if status.load() != 0:
    #     raise Error("Failed to open file descriptor" + String(file_descriptor))

    with Str(size=buffer_size) as buffer:
        var pre_read = start - now()
        # var fd_ptr = file_descriptor.cast[DType.uint64]()
        # print("fd_ptr: ", file_descriptor , fd_ptr)
        var k = fgetc(fd)
        # var read_count = fread(buffer.vector.data.value, sizeof[UInt8](), 4096, Pointer[UInt64].address_of(file_descriptor))
        # var read_count: c_ssize_t = external_call[
        #     "read", c_ssize_t, c_int, char_pointer, c_size_t
        # ](file_descriptor, buffer.vector.data, buffer_size)
        var post_read = start - now()
        # if read_count == -1:
        #     raise Error("Failed to read file descriptor" + String(file_descriptor))

        print("Pre read: ", pre_read)
        print("Post read: ", post_read)
        # for stdin, stdout, stderr, we can do this approximation
        # normally we would decode to utf-8 as we go and check for \n, but we can't do that now because
        # we don't have easy to use utf-8 support.
        # if read_count == buffer_size:
        #     raise Error(
        #         "You can only read up to "
        #         + String(buffer_size)
        #         + " bytes. "
        #         "Wait for UTF-8 support in Mojo for better handling of long inputs."
        #     )

        # return buffer.to_string(int(read_count))
        return chr(int(k))


# fn read_string_from_fd(file_descriptor: c_int, size: Int = 4096) raises -> String:
#     var buffer: Str
#     with Str(size=size) as buffer:
#         var read_count: c_ssize_t = external_call[
#             "read", c_ssize_t, c_int, char_pointer, c_size_t
#         ](file_descriptor, buffer.vector.data, size)
#         if read_count == -1:
#             raise Error("Failed to read file descriptor" + String(file_descriptor))

#         # for stdin, stdout, stderr, we can do this approximation
#         # normally we would decode to utf-8 as we go and check for \n, but we can't do that now because
#         # we don't have easy to use utf-8 support.
#         if read_count == size:
#             return buffer.to_string(read_count)

#         raise Error(
#             "You can only read up to "
#             + String(size)
#             + " bytes. "
#             "Wait for UTF-8 support in Mojo for better handling of long inputs."
#         )


fn read_bytes_from_fd(
    file_descriptor: c_int, size: Int = 4096
) raises -> List[c_char]:
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


# fn read_from_stdin() raises -> String:
#     var stdin = FD_STDIN.cast[DType.uint64]()
#     return read_string_from_fd(stdin)
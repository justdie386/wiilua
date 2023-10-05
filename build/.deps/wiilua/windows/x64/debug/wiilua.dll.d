{
    files = {
        [[build\.objs\wiilua\windows\x64\debug\src\wiilua.c.obj]]
    },
    values = {
        [[C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.37.32822\bin\HostX64\x64\link.exe]],
        {
            "-nologo",
            "-machine:x64",
            [[-libpath:C:\Users\justi\AppData\Local\.xmake\packages\w\wiiuse\@default\8574311f4b544fa89a3d8c3ee79d1929\lib]],
            "wiiuse.lib",
            "ws2_32.lib",
            "Hid.lib",
            "Setupapi.lib"
        }
    }
}
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_CROSSCOMPILING TRUE)

# Set the compiler paths
set(CMAKE_C_COMPILER /opt/amiga13/bin/m68k-amigaos-gcc)
set(CMAKE_CXX_COMPILER /opt/amiga13/bin/m68k-amigaos-g++)

# Set the prefix and path for the toolchain
set(TOOLCHAIN_PREFIX m68k-amigaos)
set(TOOLCHAIN_PATH /opt/amiga13)

# Configure target platform specifics
set(M68K_CPU 68000)
set(M68K_FPU soft)
set(M68K_CRT nix20)

# Configure sysroot
set(CMAKE_FIND_ROOT_PATH /opt/amiga13)

# Set flags
set(CMAKE_C_FLAGS "-m68000 -msoft-float -fomit-frame-pointer -mcrt=nix20")
set(CMAKE_CXX_FLAGS "-m68000 -msoft-float -fomit-frame-pointer -mcrt=nix20")

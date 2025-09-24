XVoir: FSTD meta information visualisation program

# At CMC

## Build dependencies

- CMake 3.20+
- librmn

## Environment

Load the right environment, depending on the architecture you need.  This
will load the specified compiler and its parameters, and set the
`EC_CMAKE_MODULE_PATH` variable for the `cmake_rpn` modules.

- Example for ppp6/sc6 and icelake specific architecture:

```
. r.load.dot mrd/rpn/code-tools/latest/env/rhel-8-icelake-64@inteloneapi-2025.1.0
```

- Example for generic architecture on ppp6/sc6

```
. r.load.dot mrd/rpn/code-tools/latest/env/rhel-8-amd64-64@inteloneapi-2025.1.0
```

- Example for GNU on any architecture:

```
. r.load.dot mrd/rpn/code-tools/latest/env/gnu
```

You will also need a version of librmn: either load it from ssm
(. r.load.dot rpn/libs/...) or provide the path to cmake install directory
if you compiled it.

## Build and install

```
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=[your install path] [-Drmn_ROOT=[path to librmn]]
make -j 4
make package
```

# Outside CMC (external users)

## Build dependencies

- CMake 3.20+
- librmn with shared libraries (https://github.com/ECCC-ASTD-MRD/librmn/)

`cmake_rpn` is included as a git submodule.  Please clone with the
`--recursive` option or run `git submodule update --init --recursive` in the
git repo after having cloned.

## Build and install

```
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${your_choice} -Drmn_ROOT=${librmn_install_path}
make -j 4
make install
```

#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze tb.vhd"
ghdl -a tb.vhd

echo "Build main.c"
gcc main.c -o main -ldl

#---

echo "Build tb.so [GHDL]"
ghdl -e -Wl,-Wl,--version-script=../../vhpidirect.ver -o tb.so tb

echo "Execute main"
./main

# OR

echo "Build tb.so [GHDL -Wl,-shared]"
ghdl -e -Wl,-shared -Wl,-Wl,--version-script=../../vhpidirect.ver -o tb.so tb

echo "Execute main"
./main

# OR

echo "Build tb.so [GCC]"
gcc main.c -Wl,`ghdl --list-link tb` -Wl,--version-script=../../vhpidirect.ver -o tb.so

echo "Execute main"
./main

# OR

echo "Build tb.so [GCC -shared]"
gcc main.c -shared -Wl,`ghdl --list-link tb` -Wl,--version-script=../../vhpidirect.ver -o tb.so

echo "Execute main"
./main

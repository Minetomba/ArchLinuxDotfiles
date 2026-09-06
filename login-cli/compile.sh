#!/bin/bash
echo "Compiling login-cli..."
gcc -Wall -Wextra -Wpedantic -O2 src/login-cli.c -o bin/login-cli -lpam -lpam_misc
echo "Stripping..."
strip bin/login-cli
echo "Compilation complete."
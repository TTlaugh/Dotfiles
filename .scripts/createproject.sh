#!/usr/bin/env bash

# Description: Auto-generate C/C++ project.
# Dependencies:
# Tips: Set alias in your .bashrc or .zshrc
#   Ex: alias mkpr="~/.scripts/createproject.sh"

set -euo pipefail

echo "Type?
1: C
2: CPP"
read -p "Choose number: " filetype
read -p "Enter project name: " project
read -p "Enter execute file name: " exe

read -p "Create '"$project"' folder? [Y/n] " yn
if [[ "$yn" = "y" ]] || [[ "$yn" = "Y" ]] || [[ "$yn" = "yes" ]] || [[ "$yn" = "Yes" ]] || [[ -z "$yn" ]]; then
    if [[ ! -d "$project" ]]; then
        mkdir "$project" && cd "$project"
        [[ "$?" != "0" ]] && echo -e "Error: Incorrect directory!\nExit."
    else
        echo "$project folder existed."
        exit 1
    fi
fi
mkdir Debug bin src include lib

if [[ "$filetype" = "1" ]]; then
echo -e "#include <stdio.h>
#include <stdlib.h>\n
int main (int argc, char const *argv[])
{
	printf(\"Hello world!\\n\");
	return 0;
}"\
>> src/main.c

echo -e "cmake_minimum_required(VERSION 3.10)\n
project("$project" VERSION 1.0)\n
file(GLOB_RECURSE SRC_FILES src/*.c)
add_executable("$exe" \${SRC_FILES})
target_include_directories("$exe" PUBLIC \${CMAKE_CURRENT_SOURCE_DIR}/include)"\
>> CMakeLists.txt

elif [[ "$filetype" = "2" ]]; then
echo -e "#include <iostream>\n
using namespace std;\n
int main (int argc, char const *argv[])
{
	cout << \"Hello world!\" << endl;
	return 0;
}"\
>> src/main.cpp

echo -e "cmake_minimum_required(VERSION 3.10)\n
project("$project" VERSION 1.0)\n
file(GLOB_RECURSE SRC_FILES src/*.cpp)
add_executable("$exe" \${SRC_FILES})
target_include_directories("$exe" PUBLIC \${CMAKE_CURRENT_SOURCE_DIR}/include)"\
>> CMakeLists.txt

else
	exit 1
fi

echo "clang
%c -std=c11
%cpp -std=c++2a
%h %hpp --include=Global.h"\
>> .ccls

echo -e "{
	\"configurations\": {
		\"Launch\": {
			\"adapter\": \"vscode-cpptools\",
			\"configuration\": {
				\"request\": \"launch\",
				\"program\": \"Debug/"$exe"\",
				\"cwd\": \""$PWD"\",
				\"externalConsole\": true,
				\"MIMode\": \"gdb\"
			}
		}
	}
}"\
>> .vimspector.json

echo -e "Create project successfully!\n"


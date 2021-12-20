#!/usr/bin/env bash

# Description: Auto-generate C/C++ project.
# Dependencies:
# Tips: Set alias in your .bashrc or .zshrc
#   Ex: alias mkpr="~/.scripts/createproject.sh"

set -euo pipefail

create_folder() {
    read -r -p "Create $project folder? [Y/n] " yn
    if [[ "$yn" = "y" ]] || [[ "$yn" = "Y" ]] || [[ "$yn" = "yes" ]] || [[ "$yn" = "Yes" ]] || [[ -z "$yn" ]]; then
        if [[ ! -d "$project" ]]; then
            if ! mkdir -p "$project"; then
                echo "Error: Incorrect directory." && exit 1
            fi
        else
            echo "$project folder existed."
            exit 0
        fi
    fi
    cd "$project"
    mkdir -p Debug bin src include lib
}

create_main() {
    if [[ "$language" = "c" ]]; then
        {
            echo -e "#include <stdio.h>"
            echo -e "#include <stdlib.h>\n"
            echo -e "int main (int argc, char const *argv[])"
            echo -e "{"
            echo -e "	printf(\"Hello world!\\\n\");"
            echo -e "	return 0;"
            echo -e "}"
        } >> src/main.c
    elif [[ "$language" = "cpp" ]]; then
        {
            echo -e "#include <iostream>\n"
            echo -e "using namespace std;\n"
            echo -e "int main (int argc, char const *argv[])"
            echo -e "{"
            echo -e "	cout << \"Hello world!\" << endl;"
            echo -e "	return 0;"
            echo -e "}"
        } >> src/main.cpp
    else
    	exit 1
    fi
}

create_cmake() {
    {
        echo -e "cmake_minimum_required(VERSION 3.10)\n"
        echo -e "project($project VERSION 1.0)\n"
        echo -e "file(GLOB_RECURSE SRC_FILES src/*.$language)"
        echo -e "add_executable($exe \${SRC_FILES})"
        echo -e "target_include_directories($exe PUBLIC \${CMAKE_CURRENT_SOURCE_DIR}/include)"
    } >> CMakeLists.txt
}

create_ccls() {
    {
        echo "clang"
        echo "%c -std=c11"
        echo "%cpp -std=c++2a"
        echo "%h %hpp --include=Global.h"
    } >> .ccls
}

create_vimspector() {
    {
        echo -e "{"
        echo -e "	\"configurations\": {"
        echo -e "		\"Launch\": {"
        echo -e "			\"adapter\": \"vscode-cpptools\","
        echo -e "			\"configuration\": {"
        echo -e "				\"request\": \"launch\","
        echo -e "				\"program\": \"Debug/$exe\","
        echo -e "				\"cwd\": \"$PWD\","
        echo -e "				\"externalConsole\": true,"
        echo -e "				\"MIMode\": \"gdb\""
        echo -e "			}"
        echo -e "		}"
        echo -e "	}"
        echo -e "}"
    } >> .vimspector.json
}

main() {
    read -r -p "Enter project name: " project
    read -r -p "Enter execute file name: " exe
    read -r -p "'c' or 'cpp'?: " language
    [[ "$language" != "c" ]] && [[ "$language" != "cpp" ]] && exit 1
    
    create_folder
    create_main
    create_cmake
    create_ccls
    create_vimspector
    
    echo -e "Create project successfully!\n"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

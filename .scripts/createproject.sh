#!/usr/bin/env bash

# Description: Auto-generate C/C++ project.
# Dependencies:
# Tips: Set alias in your .bashrc or .zshrc
#   Ex: alias mkpr="~/.scripts/createproject.sh"

set -euo pipefail

create_folder() {
    read -p "Create '"$project"' folder? [Y/n] " yn
    if [[ "$yn" = "y" ]] || [[ "$yn" = "Y" ]] || [[ "$yn" = "yes" ]] || [[ "$yn" = "Yes" ]] || [[ -z "$yn" ]]; then
        if [[ ! -d "$project" ]]; then
            mkdir "$project" && cd "$project"
            [[ "$?" != "0" ]] && echo "Error: Incorrect directory!"
        else
            echo "$project folder existed."
            exit project
        fi
    fi
    mkdir Debug bin src include lib
}

create_main() {
    if [[ "$language" = "c" ]]; then
        echo -e "#include <stdio.h>"                        >> src/main.c
        echo -e "#include <stdlib.h>\n"                     >> src/main.c
        echo -e "int main (int argc, char const *argv[])"   >> src/main.c
        echo -e "{"                                         >> src/main.c
        echo -e "	printf(\"Hello world!\\\n\");"          >> src/main.c
        echo -e "	return 0;"                              >> src/main.c
        echo -e "}"                                         >> src/main.c
    elif [[ "$language" = "cpp" ]]; then
        echo -e "#include <iostream>\n"                     >> src/main.cpp
        echo -e "using namespace std;\n"                    >> src/main.cpp
        echo -e "int main (int argc, char const *argv[])"   >> src/main.cpp
        echo -e "{"                                         >> src/main.cpp
        echo -e "	cout << \"Hello world!\" << endl;"      >> src/main.cpp
        echo -e "	return 0;"                              >> src/main.cpp
        echo -e "}"                                         >> src/main.cpp
    else
    	exit 1
    fi
}

create_cmake() {
    echo -e "cmake_minimum_required(VERSION 3.10)\n"                                         >> CMakeLists.txt
    echo -e "project("$project" VERSION 1.0)\n"                                              >> CMakeLists.txt
    echo -e "file(GLOB_RECURSE SRC_FILES src/*."$language")"                                 >> CMakeLists.txt
    echo -e "add_executable("$exe" \${SRC_FILES})"                                           >> CMakeLists.txt
    echo -e "target_include_directories("$exe" PUBLIC \${CMAKE_CURRENT_SOURCE_DIR}/include)" >> CMakeLists.txt
}

create_ccls() {
    echo "clang"                      >> .ccls
    echo "%c -std=c11"                >> .ccls
    echo "%cpp -std=c++2a"            >> .ccls
    echo "%h %hpp --include=Global.h" >> .ccls
}

create_vimspector() {
    echo -e "{"                                                 >> .vimspector.json
    echo -e "	\"configurations\": {"                          >> .vimspector.json
    echo -e "		\"Launch\": {"                              >> .vimspector.json
    echo -e "			\"adapter\": \"vscode-cpptools\","      >> .vimspector.json
    echo -e "			\"configuration\": {"                   >> .vimspector.json
    echo -e "				\"request\": \"launch\","           >> .vimspector.json
    echo -e "				\"program\": \"Debug/"$exe"\","     >> .vimspector.json
    echo -e "				\"cwd\": \""$PWD"\","               >> .vimspector.json
    echo -e "				\"externalConsole\": true,"         >> .vimspector.json
    echo -e "				\"MIMode\": \"gdb\""                >> .vimspector.json
    echo -e "			}"                                      >> .vimspector.json
    echo -e "		}"                                          >> .vimspector.json
    echo -e "	}"                                              >> .vimspector.json
    echo -e "}"                                                 >> .vimspector.json
}

main() {
    read -p "Enter project name: " project
    read -p "Enter execute file name: " exe
    read -p "'c' or 'cpp'?: " language
    [[ "$language" != "c" ]] && [[ "$language" != "cpp" ]] && exit 1
    
    create_folder
    create_main
    create_cmake
    create_ccls
    create_vimspector
    
    echo -e "Create project successfully!\n"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

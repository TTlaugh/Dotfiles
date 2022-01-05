# Vim Tips
## Changing case in Vim
- `~`    : Changes the case of current character.
- `guu`  : Change current line from upper to lower.
- `gUU`  : Change current LINE from lower to upper.
- `guw`  : Change to end of current WORD from upper to lower.
- `guaw` : Change all of current WORD to lower.
- `gUw`  : Change to end of current WORD from lower to upper.
- `gUaw` : Change all of current WORD to upper.
- `g~~`  : Invert case to entire line.
- `g~w`  : Invert case to current WORD.
- `guG`  : Change to lowercase until the end of document.
- `gU)`  : Change until end of sentence to upper case.
- `gu}`  : Change to end of paragraph to lower case.
- `gU5j` : Change 5 lines below to upper case.
- `gu3k` : Change 3 lines above to lower case.
## Moving to and deleting inside `()  []  {}  ''  ""  ``  <>`
- Delete all word inside
```
di(
di{
di[
di"
...
```
- Delete and put you into **insert** mode.
```
ci(
ci{
ci[
ci"
...
```
> See `:h text-objects`
## Find and edit
- Text:
```
test <!-- line 1 -->
test <!-- line 2 -->
test <!-- line 3 -->
test <!-- line 4 -->
test <!-- line 5 -->
```
- Example 1:
```
:g/<!-- [A-Z]\|[0-9]/norm $da<0P
```
  - Result:
    ```
    <!-- line 1 -->test 
    <!-- line 2 -->test 
    <!-- line 3 -->test 
    <!-- line 4 -->test 
    <!-- line 5 -->test 
    ```

const help*: string = """

NNOTES

A dead simple CLI for taking quick notes!

Usage: nnotes [command] [args...]

Example: 
> $ nnotes new Linux
> $ New notebook "Linux" created!

> $ nnotes add "rm -rf can ruin your day!" Linux
> $ Note 1 added to "Linux" notebook!

Commands:
new       <notebook-name> <note*>  Creates a new notebook with the given name
add       <note> <notebook>       Adds a note to an existing notebook
list            -                 List all notebook and number of notes in each
updaten   <note-id> <notebook>    Updates a note in a notebook
updateb   <notbook>               Updates a notebook name
deln      <note-id> <notebook>    Deletes a note from a notebook
delb      <notebook>              Deletes a notebook
help                              Displays this message

* denotes an optional argument
"""


import ".."/persistence/models
import std/[syncio, strformat, os, streams, strutils, sequtils]

const dataDir = getDataDir() & "nnotes/notebooks"

const help*: string = """

NNOTES

A dead simple CLI for taking quick notes!

Usage: nnotes [command] [args...]

Example: 
> $ nnotes new Linux
> $ New notebook "Linux" created!

> $ nnotes add "rm -rf can ruin your day!" Linux
> $ Note 1 added to "Linux" notebook!

Commands    Args                      Description
new         <notebook-name> <note*>   Creates a new notebook with the given name
add         <note> <notebook>         Adds a note to an existing notebook
list            -                     List all notebook and number of notes in each
updaten     <note-id> <notebook>      Updates a note in a notebook
updateb     <notbook>                 Updates a notebook name
deln        <note-id> <notebook>      Deletes a note from a notebook
delb        <notebook>                Deletes a notebook
help                                  Displays this message
-- * denotes an optional argument --
"""

proc newCmd*(args: seq[string]): string =
  writeFile(&"{dataDir}/{args[1]}.txt", "")

# addCmd
proc addCmd*(args: seq[string]): string =
  let fstrm = newFileStream(&"{dataDir}/{args[2]}.txt", fmAppend)
  fstrm.writeLine(args[1])
  fstrm.close()
  &"Added {args[1]} to {args[2]}!"

proc listCmd*(args: seq[string]): string =
  var lines = readFile(&"{dataDir}/{args[1]}.txt").split("\n").mapIt(Note(content: it))
  $Notebook(title: args[1], notes: lines[0..^2], count: len(lines) - 1)

# listCmd
# updatenCmd
# updatebCmd
# delnCmd
# delbCmd

proc parseCmdArgs*(args: seq[string]): string =
  try:
    if args.len == 0:
      help
    else:
      case args[0]:
        of "new": $newCmd(args)
        of "add": $addCmd(args)
        of "list": $listCmd(args)
        of "updaten": "TODO!"
        of "updateb": "TODO!"
        of "deln": "TODO!"
        of "delb": "TODO!"
        else: help
  except OSError as osErr:
    echo osErr.getStackTrace()
    "errror"

import models
import std/[syncio, strformat, os, strutils, sequtils, paths]

const dataDir = getDataDir() & "nnotes/notebooks"
const help*: string =
  """

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
  list        <notebook>                List all notes from a notebook
  overview        -                     Lists each notebook with their current number of notes
  updaten     <note-id> <notebook>      Updates a note in a notebook
  updateb     <notbook>                 Updates a notebook name
  deln        <note-id> <notebook>      Deletes a note from a notebook
  delb        <notebook>                Deletes a notebook
  help                                  Displays this message
  -- * denotes an optional argument --
  """

proc newCmd*(title: string): string =
  ##[
    Creates a new `Notebook` with the given name string.
    If the `Notebook` already exists, no new `Notebook`
    is created or overwritten.

    Example:
      > $ newCmd("NewNotes") # Returns "Notebook created: NewNotes"
      > $ newCmd("NewNOtes") # Returns "The notebook NewNotes already exists!"
  ]##
  let path = &"{dataDir}/{title}.txt"
  if fileExists(path):
    return &"The notebook {title} already exists!"
  else:
    open(path, fmWrite, 1).close()
    return &"Notebook created: {title}"

proc addCmd*(note, nbTitle: string): string =
  let fd = open(&"{dataDir}/{nbTitle}.txt", fmAppend)
  fd.writeLine(note)
  fd.close()
  &"Added {note} to {nbTitle}!"

proc listCmd*(nbTitle: string): string =
  var lines = readFile(&"{dataDir}/{nbTitle}.txt").split("\n").mapIt(Note(content: it))
  let nb = Notebook(title: nbTitle, notes: lines, count: len(lines))
  result = &"{nb.title}\n  "
  var idx = 1
  for note in nb.notes:
    result = &"{result}{idx}. {note.content}\n  "
    idx += 1

proc overviewCmd*(): string =
  result = "Notebooks:\n"
  for file in walkDirRec &"{dataDir}":
    var fp = string(extractFilename(Path(file)))
    var lineCount = 0
    for line in lines &"{dataDir}/{fp}": inc(lineCount)
    result = &"{result}  {fp[0..^5]}({lineCount})\n"

# updatenCmd
proc updateNoteCmd*(): string = "TODO!"

# updatebCmd
proc updateNotebookCmd*(): string = "TODO!"

# delnCmd
proc deleteNoteCmd*(): string = "TODO!"

proc deleteNoteBookCmd*(nbTitle: string, remProc: proc (
    file: string): bool = tryRemoveFile): string =
  discard remProc(&"{dataDir}/{nbTitle}.txt")
  &"Notebook deleted: {nbTitle}"


proc parseCmdArgs*(args: seq[string]): string =
  try:
    if args.len == 0:
      help
    else:
      case args[0]:
        of "new": $newCmd(args[1])
        of "add": $addCmd(args[1], args[2])
        of "list": $listCmd(args[1])
        of "overview": $overviewCmd()
        of "updaten": $updateNoteCmd()
        of "updateb": $updateNotebookCmd()
        of "deln": $deleteNoteCmd()
        of "delb": deleteNoteBookCmd(args[1])
        else: help
  except OSError as osErr:
    echo osErr.getStackTrace()
    "errror"

  #[
  TODO:
  - [] make all cmd procs take a function the performs IO instead of doing it in body
  - [] error handling
  ]#

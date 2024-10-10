import cli/cmd
import std/os

when isMainModule:
  let dataDirCheck = existsOrCreateDir(getDataDir() & "nnotes")
  let noteBookDirCheck = existsOrCreateDir(getDataDir() & "nnotes/notebooks")

  if not dataDirCheck: echo "Created \"$XDG_DATA_HOME/nnotes\" directory!"
  if not noteBookDirCheck: echo "Created notebook dir!"

  echo parseCmdArgs(commandLineParams())

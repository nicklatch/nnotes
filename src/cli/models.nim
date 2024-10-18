type
  Note* = object
    content*: string

  Notebook* = object
    title*: string
    notes*: seq[Note]
    count*: int = 0



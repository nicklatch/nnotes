type Note* = object
  content*: string

type Notebook* = object
  title*: string
  notes*: seq[Note]
  count*: int = 0



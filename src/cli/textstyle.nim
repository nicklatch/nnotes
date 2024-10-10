import std/strformat

type TextLayer* = enum
  fg = "38"
  bg = "48"

type TextDecoration* = enum
  tdReset = "0"
  tdBold = "1"
  tdDim = "2"
  tdItalic = "3"
  tdUnderline = "4"
  tdBlinking = "5"
  tdInverse = "7"
  tdHidden = "8"
  tdStrikethrough = "9"

type ColorSpace* = enum
  csRgb = "2"
  csXterm = "5" # 256

func esc*(codeString: string): string =
  &"\e[{codeString}m"



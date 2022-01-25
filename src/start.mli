type word =
  | Good of string
  | Bad

val letters : char list

val is_letter : char -> bool

val determine : string -> word

type word =
  | Good of string
  | Bad

val letters : char list

val is_letter : char -> bool

val determine : string -> word

val get_output : string -> string -> int -> string list -> string list

val modify_letters :
  string -> string -> char list list -> int -> char list list

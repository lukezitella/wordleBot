(** Type that determines if an inputted word is valid for wordle *)
type word =
  | Good of string
  | Bad

val letters : char list
(** list of all the english letters *)

val is_letter : char -> bool
(** is_letter character is true if char is an english character, can be
    uppercase or lowercase *)

val determine : string -> word
(** determine word is a Good word if the word is a valid wordle word,
    and Bad if not *)

val get_output : string -> string -> int -> string list -> string list
(** get_output correct word place acc is a list of descriptions about
    the letters of the guess, word. Info about whether the characters of
    the guess are in the right place, right character, or not the right
    character are included in the list to be printed.*)

val modify_letters :
  string -> string -> char list list -> int -> char list list
(** modify_letters correct guess letters place is the possible letters
    to guess with based on the given guess and correct word. Should
    start at 0. *)

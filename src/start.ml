type word =
  | Good of string
  | Bad

let letters =
  [
    'a';
    'b';
    'c';
    'd';
    'e';
    'f';
    'g';
    'h';
    'i';
    'j';
    'k';
    'l';
    'm';
    'n';
    'o';
    'p';
    'q';
    'r';
    's';
    't';
    'u';
    'v';
    'w';
    'y';
    'x';
    'z';
  ]

let is_letter word = List.mem word letters

let determine word =
  if String.length word != 5 then Bad
  else
    let is = ref true in
    let _ =
      for i = 0 to 4 do
        if is_letter (String.get word i) = false then is := false
        else ()
      done
    in
    if !is then Good word else Bad

let rec start hello =
  let _ = print_endline "enter your guess" in
  let word = read_line () in
  let word = String.lowercase_ascii word in
  match determine word with
  | Bad ->
      let _ = print_endline "invalid word, try again" in
      start "h"
  | Good _ -> print_endline ("nice" ^ hello)

let () =
  let () = print_endline "game starting" in
  start "bro"

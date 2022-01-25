open Wordlebot

let letters = Start.letters

let rec print_possible_helper possibles template acc =
  match template with
  | h :: t ->
      if List.mem h possibles then
        print_possible_helper possibles t (acc ^ String.make 1 h ^ " ")
      else print_possible_helper possibles t (acc ^ "  ")
  | [] -> acc ^ "]"

let rec print_possible set =
  let () =
    print_endline
      (print_possible_helper (List.nth set 0)
         [ 'q'; 'w'; 'e'; 'r'; 't'; 'y'; 'u'; 'i'; 'o'; 'p' ]
         "[")
  in
  let () =
    print_endline
      (print_possible_helper (List.nth set 0)
         [ 'a'; 's'; 'd'; 'f'; 'g'; 'h'; 'j'; 'k'; 'l' ]
         "[")
  in
  let () =
    print_endline
      (print_possible_helper (List.nth set 0)
         [ 'z'; 'x'; 'c'; 'v'; 'b'; 'n'; 'm' ]
         "[")
  in
  ()

let rec start hello =
  let _ = print_endline "enter your guess" in
  let word = read_line () in
  let word = String.lowercase_ascii word in
  match Start.determine word with
  | Bad ->
      let _ = print_endline "invalid word, try again" in
      start "h"
  | Good _ -> print_endline ("nice" ^ hello)

let () =
  let () = print_endline "game starting" in
  start "bro"

open Wordlebot

let letters = Start.letters

let row1 = [ 'q'; 'w'; 'e'; 'r'; 't'; 'y'; 'u'; 'i'; 'o'; 'p' ]

let row2 = [ 'a'; 's'; 'd'; 'f'; 'g'; 'h'; 'j'; 'k'; 'l' ]

let row3 = [ 'z'; 'x'; 'c'; 'v'; 'b'; 'n'; 'm' ]

let rec print_possible_helper possibles template acc =
  match template with
  | h :: t ->
      if List.mem h possibles then
        print_possible_helper possibles t (acc ^ String.make 1 h ^ " ")
      else print_possible_helper possibles t (acc ^ "# ")
  | [] -> acc ^ "]"

let print_possible set =
  let () =
    print_endline (print_possible_helper (List.nth set 0) row1 "[")
  in
  let () =
    print_endline (print_possible_helper (List.nth set 1) row2 "[")
  in
  let () =
    print_endline (print_possible_helper (List.nth set 2) row3 "[")
  in
  ()

let rec print_each lst =
  match lst with
  | h :: t ->
      let _ = print_endline h in
      print_each t
  | [] -> ()

let rec start correct tries letters =
  let _ = print_endline "enter your guess" in
  let _ = print_possible letters in
  let word = read_line () in
  if word = "bot" then Bot.solve correct 1 Data.data
  else
    let word = String.lowercase_ascii word in
    match Start.determine word with
    | Bad ->
        let _ = print_endline "invalid word, try again" in
        start "hello" (tries + 1) letters
    | Good x ->
        if x = correct then
          print_endline
            ("you win! word was " ^ correct ^ ". You guessed it in "
           ^ string_of_int tries ^ " tries!")
        else
          let _ = print_endline "try again" in
          let _ = print_each (Start.get_output correct x 4 []) in
          let letters = Start.modify_letters correct x letters 0 in
          start correct (tries + 1) letters

let () =
  let _ =
    print_endline
      "enter random for a random word, or enter a word to use"
  in
  let word = read_line () in
  match Start.determine word with
  | Bad ->
      if word = "test" then
        let data = Data.data in
        let x = ref 0 in
        let _ =
          for i = 0 to 5756 do
            x := !x + Bot.solve_test (List.nth data i) 0 data
          done
        in
        print_endline
          ("average of "
          ^ string_of_float (Float.div (float_of_int !x) 5757.)
          ^ " attempts per word")
      else
        let () = print_endline "game starting" in
        start
          (List.nth Data.data (Random.int 5756))
          1 [ row1; row2; row3 ]
  | Good word ->
      let () = print_endline "game starting" in
      start word 1 [ row1; row2; row3 ]

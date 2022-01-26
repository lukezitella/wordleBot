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

let rec get_output correct word place acc =
  if place = -1 then acc
  else
    let current = String.get word place in
    let correct_char = String.get correct place in
    if String.contains correct current then
      if correct_char = current then
        get_output correct word (place - 1)
          (("You guessed " ^ String.make 1 current
          ^ " correctly at place " ^ string_of_int place)
          :: acc)
      else
        get_output correct word (place - 1)
          (("You guessed " ^ String.make 1 current
          ^ " correctly at the wrong place,  "
           ^ string_of_int (place + 1)
           ^ " is incorrect")
          :: acc)
    else
      get_output correct word (place - 1)
        ((String.make 1 current ^ " is not in the word") :: acc)

let rec remove_list letter list =
  match list with
  | [] -> []
  | h :: t ->
      if Char.equal letter h then t else h :: remove_list letter t

let remove_letter letter letters =
  match letters with
  | [ row1; row2; row3 ] ->
      let list1 = remove_list letter row1 in
      let list2 = remove_list letter row2 in
      let list3 = remove_list letter row3 in
      [ list1; list2; list3 ]
  | _ -> failwith "impossible"

let rec modify_letters correct word letters place =
  if place = 5 then letters
  else
    let current = String.get word place in

    if String.contains correct current = false then
      modify_letters correct word
        (remove_letter current letters)
        (place + 1)
    else modify_letters correct word letters (place + 1)

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
    if !is then
      if List.mem word Data.data = false then Bad else Good word
    else Bad

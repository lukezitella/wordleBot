let rec get_chars word place =
  if place = 5 then []
  else String.get word place :: get_chars word (place + 1)

let rec denom_helper chars target place =
  if place = 5 then 0
  else if String.contains target (List.nth chars place) then
    1 + denom_helper chars target (place + 1)
  else denom_helper chars target (place + 1)

let rec denominator chars data count =
  match data with
  | h :: t ->
      let count = count + denom_helper chars h 0 in
      denominator chars t count
  | [] -> count

let rec find_common lst data (max, word) =
  match lst with
  | h :: t ->
      let next = denominator (get_chars h 0) data 0 in
      if next > max then find_common t data (next, h)
      else find_common t data (max, word)
  | [] -> word

let rec info_correct correct guess place =
  if place = 5 then []
  else
    let current = String.get guess place in
    let right = String.get correct place in

    if String.contains correct current then
      if Char.equal current right then
        (current, place, -1) :: info_correct correct guess (place + 1)
      else (current, -1, place) :: info_correct correct guess (place + 1)
    else info_correct correct guess (place + 1)

let rec info_false correct guess place =
  if place = 5 then []
  else
    let current = String.get guess place in
    if String.contains correct current = false then
      current :: info_false correct guess (place + 1)
    else info_false correct guess (place + 1)

let rec correct corrects word =
  match corrects with
  | [] -> true
  | (chara, num, poss) :: t ->
      if String.contains word chara = false then false
      else if num = -1 then
        let atHere = String.get word poss in

        if Char.equal atHere chara then false else correct t word
      else if Char.equal (String.get word num) chara then correct t word
      else false

let rec not_false falses word =
  match falses with
  | [] -> true
  | h :: t -> if String.contains word h then false else not_false t word

let rec remove_last_guess data guess =
  match data with
  | [] -> []
  | h :: t ->
      if String.equal guess h then t else h :: remove_last_guess t guess

let rec eliminate guess data corrects falses =
  match data with
  | [] -> []
  | h :: t ->
      if correct corrects h = false then
        eliminate guess t corrects falses
      else if not_false falses h then
        h :: eliminate guess t corrects falses
      else eliminate guess t corrects falses

let rec solve correct tries data =
  let guess = find_common data data (0, "adieu") in
  if guess = correct then
    print_endline
      ("the word is " ^ correct ^ "!!! Finished in "
     ^ string_of_int tries ^ " tries!!!")
  else
    let _ =
      print_endline
        (guess ^ " was wrong. " ^ string_of_int tries
       ^ " tries exhausted.")
    in
    let data =
      eliminate guess data
        (info_correct correct guess 0)
        (info_false correct guess 0)
    in
    let data = remove_last_guess data guess in

    let _ =
      print_endline (string_of_int (List.length data) ^ " words left")
    in
    solve correct (tries + 1) data

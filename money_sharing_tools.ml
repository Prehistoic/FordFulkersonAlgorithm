type path = string

let read_amount line =
    try Scanf.sscanf line "%d %d" (fun _ a -> a)
    with e ->
        Printf.printf "Cannot read amount in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

let read_amount_person line id =
    try Scanf.sscanf line "%d %d" (fun person a -> (if person=id then a else 0))
    with e ->
        Printf.printf "Cannot read amount in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

let amount_from_file path =

    let infile = open_in path in

    let rec loop l amount =
        try
            let line = input_line infile in

            let line = String.trim line in

            let (l2, amount2) =
                if line = "" then (l, amount)
                else (l+1, amount + (read_amount line))
            in
            loop l2 amount2
        with End_of_file -> amount (* Done *)
    in

    let final_amount = loop 0 0 in

    close_in infile ;
    final_amount

let get_diff path id due =

    let infile = open_in path in

    let rec loop l amount_paid =
        try 
            let line = input_line infile in
            let line = String.trim line in
            let (l2, amount_paid2) =
                if line = "" then (l, amount_paid)
                else (l+1, amount_paid + (read_amount_person line id))
            in
            loop l2 amount_paid2
        with End_of_file -> amount_paid
    in

    let final_amount_paid = loop 0 0 in

    close_in infile ;
    final_amount_paid - due

let rec create_list_person path number_of_people dueperperson id acu =
    if id = number_of_people then acu
    else create_list_person path number_of_people dueperperson (id+1) ((id, get_diff path id dueperperson) :: acu)

(*let create_graph graph list_person id_sink =*)
    
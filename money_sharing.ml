open Tools
open Gfile
open Ford_fulkerson
open Money_sharing_tools
open Graph

let () = 

    (* Check the number of command-line arguments *)
    if Array.length Sys.argv <> 2 then
        begin
          Printf.printf "\nUsage: %s infile number_of_people\n\n%!" Sys.argv.(0) ;
          exit 0
        end ;


    let infile = Sys.argv.(1)
    and number_of_people = int_of_string Sys.argv.(2)
    in

    (* Open file *)
    let amount = amount_from_file infile in
    let dueperperson = amount / number_of_people in
    
    let person_list = create_list_person infile number_of_people dueperperson 1 [] in
    let person_list_str = List.map (fun (a,b) -> "(" ^ string_of_int a ^"," ^ string_of_int b ^")") person_list in
    let () = List.iter (Printf.printf "%s\n") person_list_str in
    ()

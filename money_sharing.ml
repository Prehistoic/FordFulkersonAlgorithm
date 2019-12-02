open Tools
open Gfile
open Ford_fulkerson
open Money_sharing_tools
open Graph

let () = 

    (* Check the number of command-line arguments *)
    if Array.length Sys.argv <> 5 then
        begin
          Printf.printf "\nUsage: %s infile number_of_people outfile formatted_file\n\n%!" Sys.argv.(0) ;
          exit 0
        end ;


    let infile = Sys.argv.(1)
    and number_of_people = int_of_string Sys.argv.(2)
    and outfile = Sys.argv.(3)
    and formatted_file = Sys.argv.(4)
    in

    (* Open file *)
    let amount = amount_from_file infile in
    let dueperperson = amount / number_of_people in
    
    let person_list = create_list_person infile number_of_people dueperperson 1 [] in
    let person_list_str = List.map (fun (a,b) -> "(" ^ string_of_int a ^"," ^ string_of_int b ^")") person_list in
    let () = List.iter (Printf.printf "%s\n") person_list_str in
    () ;
    
    let id_source = 0 in
    let id_sink = (List.length person_list)+1 in
    let graph = create_graph empty_graph person_list id_sink in
    let graph = gmap graph (fun a -> string_of_int a) in
    let result_graph = ford_fulkerson_for_money_sharing graph id_source id_sink in
    let graph_str = gmap result_graph (fun (a,b) -> string_of_int a) in
    let graph_str = remove_empty_arcs graph_str in

    let () = write_file outfile graph_str in

    () ;

    let () = export graph_str formatted_file in

    () ;


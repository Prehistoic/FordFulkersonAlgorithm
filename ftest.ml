open Gfile
open Tools
open Ford_fulkerson

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 6 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile formatted_file\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  and formatted_file = Sys.argv.(5)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  let result_graph = ford_fulkerson_algo graph _source _sink in
  let graph_str = gmap result_graph (fun (a,b) -> "(" ^ string_of_int a ^"," ^ string_of_int b ^")") in
  

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph_str in

  () ;

  let () = export graph_str formatted_file in

  () ;


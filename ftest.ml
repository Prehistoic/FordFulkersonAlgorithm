open Gfile
open Tools

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph_of_int = gmap (from_file infile) (fun s -> int_of_string s) in
  let graph = gmap (add_arc graph_of_int 3 5 5) (fun s -> string_of_int s) in

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  ()

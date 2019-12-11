open Graph
open Tools
open Ford_fulkerson

type path = string

(*
 * @brief : get the ammount from a file
 * @param : path to the file
 * @return : the amount
*)
val amount_from_file: path -> int

(*
 * @brief : create a list with all the people in it
 * @param : path to the file, number of people, due per person, id of the person, empty list
 * @return : the list of person (id * diff to pat)
*)
val create_list_person: path -> int -> int -> int -> (int*int) list -> (int*int) list

(*
 * @brief : create a graph for the money sharing problem
 * @param : a graph, a list of people, id of the sink
 * @return : the graph
*)
val create_graph: int graph -> (int*int) list -> int -> int graph

(*
 * @brief : application de Ford Fulkerson for the money sharing problem
 * @param : a graph, a source, a sink
 * @return : the flow graph
*)
val ford_fulkerson_for_money_sharing: string graph -> id -> id -> (int*int) graph

(*
 * @brief : remove the arcs with the label 0
 * @param : a graph
 * @return : a graph without arcs with 0 as label
*)
val remove_empty_arcs: string graph -> string graph



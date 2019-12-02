open Graph

val init: string graph -> (int*int) graph

val find_path: int graph -> id -> id -> id list

val update_graph: (int*int) graph -> id list -> int -> (int*int) graph

val find_flow_variation: (int*int) graph -> id list -> int -> int

val delete_void_arcs: int graph -> int graph

(* @brief : execute ford_fulkerson algo on a graph
   @param : a flow graph, the source, the sink
   @return : a flow graph
*)
val ford_fulkerson_algo: string graph -> id -> id -> (int*int) graph

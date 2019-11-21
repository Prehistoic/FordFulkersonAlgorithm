open Graph

(* @brief : Take a string graph and create the starting graph for the algo with (labels 0,capacity)
   @param : a graph
   @returns : the init graph
*)
val init: string graph -> (int*int) graph

(* @brief : loop de l'algo
   @param : a flow graph, a residual graph, the rate of flow, the source, the sink
   @return : a flow graph
*)
(*val algorithm_loop: (int*int) graph -> int graph -> int -> int -> int -> (int*int) graph*)

val isInList: id -> id list -> bool

val filter_children: id list -> id list -> 'a out_arcs -> 'a out_arcs -> 'a out_arcs

val parcours: 'a graph -> id list -> id list -> id -> id list -> id list

val find_path: 'a graph -> id -> id -> id list

val find_flow_variation: (int*int) graph -> id list -> int -> int

val update_graph: (int*int) graph -> id list -> int -> (int*int) graph

val create_temp_graph: (int*int) graph -> int graph

val algo_loop: (int*int) graph -> id -> id -> (int*int) graph

val ford_fulkerson_algo: string graph -> id -> id -> (int*int) graph

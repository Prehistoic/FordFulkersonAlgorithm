open Graph

(* @brief : creates the initial graph for ford-fulkerson
   @param : a string graph
   @return : a flow graph
*)
val init: string graph -> (int*int) graph

(* @brief : finds a path from the source to the sink within a residual graph
   @param : a residual graph, the source, the sink
   @return : a path (an id list)
*)
val find_path: int graph -> id -> id -> id list

(* @brief : updates a flow graph by adding the new flow variation to the label of the nodes belonging to the path
   @param : a flow graph, a path, the flow variation
   @return : a flow graph
*)
val update_graph: (int*int) graph -> id list -> int -> (int*int) graph

(* @brief : find the max flow variation possible in the path specified
   @param : a flow graph, a path, an int
   @return : the flow variation (an int)
*)
val find_flow_variation: (int*int) graph -> id list -> int -> int

(* @brief : removes the arcs with the label 0
   @param : a residual graph
   @return : a residual graph
*)
val delete_void_arcs: int graph -> int graph

(* @brief : execute ford_fulkerson algo on a graph
   @param : a string graph, the source, the sink
   @return : a flow graph
*)
val ford_fulkerson_algo: string graph -> id -> id -> (int*int) graph

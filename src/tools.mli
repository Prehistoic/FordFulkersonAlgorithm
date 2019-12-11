open Graph

(*
 * @brief : map all arcs of a graph
 * @param : a graph to map, a function to apply on each arc
 * @return : a new graph mapped
*)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

(*
 * @brief : clone the nodes and delete the arcs
 * @param : a graph with nodes and arcs
 * @return : a graph with the same nodes but whitout arcs
*)
val clone_nodes: 'a graph -> 'b graph

(*
 * @brief : adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created
 * @param : a graph, the id of a node, the id of an another node, the value to add
 * @return : a graph with the value added
*)
val add_arc: int graph -> id -> id -> int -> int graph

(*Same as add_arc but with a (int*int) graph*)
val add_arc_tuple: (int*int) graph -> id -> id -> int -> (int*int) graph

(*
 * @brief : create an arc in the opposite direction of the given one
 * @param : a flow graph, a node, an other node, a value
 * @return : a flow graph
 * @note : the value is not used because the values of the new arc are calculated from the first one
*)
val add_rev_arc: (int*int) graph -> id -> id -> (int*int) -> (int*int) graph

val add_rev_arc_source_sink: (int*int) graph -> id -> id -> (int*int) -> (int*int) graph

(*
 * @brief : create the arc only if the label is different of 0
 * @param : a flow graph, a node, an other node, a value
 * @return : a graph
*)
val add_arc_no_void: int graph -> id -> id -> int -> int graph

(*same as add_arc_no_void but with a string label*)
val add_arc_no_void_string: string graph -> id -> id -> string -> string graph

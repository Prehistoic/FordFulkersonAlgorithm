open Graph

(* @brief : execute ford_fulkerson algo on a graph
   @param : a flow graph, the source, the sink
   @return : a flow graph
*)
val ford_fulkerson_algo: string graph -> id -> id -> (int*int) graph

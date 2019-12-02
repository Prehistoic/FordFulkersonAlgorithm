open Graph
open Tools
open Ford_fulkerson

type path = string

val amount_from_file: path -> int

val create_list_person: path -> int -> int -> int -> (int*int) list -> (int*int) list

val create_graph: int graph -> (int*int) list -> int -> int graph

val ford_fulkerson_for_money_sharing: string graph -> id -> id -> (int*int) graph

val remove_empty_arcs: string graph -> string graph



open Graph

type path = string

val amount_from_file: path -> int

val create_list_person: path -> int -> int -> int -> (int*int) list -> (int*int) list

val create_graph: int graph -> (int*int) list -> int -> int graph

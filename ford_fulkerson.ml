open Tools
open Graph

let init graph = 
    gmap graph (fun s -> (0,int_of_string s))

let rec isInList node nodes_list =
    match nodes_list with
    | [] -> false
    | n :: rest -> (if n=node then true else isinList node rest)

let rec dps graph marked_nodes current_node sink path =
    if current_node = sink
    then current_node :: path
    else
        let rec get_clear_node children marked_nodes =
            match children with
            | [] -> 
            | n :: rest -> (if isInList n marked_nodes 
                            then get_clear_node rest marked_nodes 
                            else n)
        in
        let children = out_arcs graph current_node
        in
            dps graph (current_node :: marked_nodes) (get_clear_node children marked_nodes) sink path
            
        

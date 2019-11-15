open Tools
open Graph

let init graph =
  gmap graph (fun s -> (0,int_of_string s))

let rec isInList n l =
  match l with
  | [] -> false
  | e :: rest -> (if e=n then true else isInList n rest)

let rec filter_children l1 l2 children acu =
  match children with
  | [] -> acu
  | (n,l) :: rest -> (if isInList n l1 || isInList n l2
                  then filter_children l1 l2 rest acu
                  else filter_children l1 l2 rest ((n,l)::acu))

let rec parcours graph nodes_to_explore marked_nodes sink result =
  match nodes_to_explore with
  | [] -> []
  | n :: rest ->
    let nodes_to_explore = rest in
    if n = sink then n :: result
    else
      let children = out_arcs graph n in
      let unmarked_children = filter_children nodes_to_explore marked_nodes children [] in
      let nodes_to_explore =  List.append (List.map (fun (n,_) -> n) unmarked_children) nodes_to_explore in
      parcours graph nodes_to_explore (n::marked_nodes) sink (n::result)

let find_path graph source sink =
  parcours graph [source] [] sink []

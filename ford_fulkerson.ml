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
  List.rev (parcours graph [source] [] sink [])

let calc_saturation_option arc =
    match arc with
    | None -> raise Not_found
    | Some (a,b) -> b-a

let calc_saturation arc =
    let (a,b) = arc in
    b-a

let rec find_flow_variation graph path var_min =
    match path with
    | [] -> raise (Failure "empty path")
    | n :: [] -> var_min
    | n :: m :: rest -> 
        let saturation = calc_saturation_option (find_arc graph n m) in
        (if saturation <  var_min
        then find_flow_variation graph (m :: rest) saturation
        else find_flow_variation graph (m :: rest) var_min)

let rec update_graph graph path saturation =
    match path with
    | [] -> raise (Failure "empty path")
    | n :: [] -> graph
    | n :: m :: rest -> update_graph (add_arc_tuple graph n m saturation) (m :: rest) saturation

let rec add_temp_arcs_process result node arcs =
    match arcs with
    | [] -> result
    | (m,(a,b)) :: rest -> 
        let saturation = calc_saturation (a,b) in
        if saturation = 0 then add_arc result m node saturation
        else if saturation = b then add_arc result node m saturation
        else add_arc result node m saturation ; add_arc result m node a

let rec parcours_temp graph nodes_to_explore marked_nodes result =
    match nodes_to_explore with
    | [] -> result
    | n :: rest ->
        let nodes_to_explore = rest in
        let children = out_arcs graph n in
        let unmarked_children = filter_children nodes_to_explore marked_nodes children [] in
        let nodes_to_explore =  List.append (List.map (fun (n,_) -> n) unmarked_children) nodes_to_explore in
        let result = add_temp_arcs_process result n (out_arcs graph n) in
        parcours_temp graph nodes_to_explore (n::marked_nodes) result

let create_temp_graph graph source =
    parcours_temp graph [source] [] (clone_nodes graph)




































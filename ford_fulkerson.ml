open Tools
open Graph

(*
	@brief : init the flow graph with 0 everywhere
  	@param : a none flow graph
  	@returns : the flow graph 
*)
let init graph =
  gmap graph (fun s -> (0,int_of_string s))

(*
	@brief : check if an element is in a list
  	@param : an element, a list
  	@returns : true or false 
*)
let rec isInList n l =
  match l with
  | [] -> false
  | e :: rest -> (if e=n then true else isInList n rest)

 (*
	@brief : check if nodes are marked in a list 
  	@param : the list of uncharted nodes, the list of the marked nodes, a list of out arcs, an acumulator
  	@returns : a list of out arcs 
*)
let rec filter_children l1 l2 children acu =
  match children with
  | [] -> acu
  | (n,l) :: rest -> (if isInList n l1 || isInList n l2
                  then filter_children l1 l2 rest acu
                  else filter_children l1 l2 rest ((n,l)::acu))

(*
	@brief : DFS
  	@param : a graph, the list if uncharted nodes, the list of marked nodes, the sink node, an acumulator
  	@returns : a list of node 
*)
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

(*
	@brief : find a path to the sink from the source
  	@param : a graph, a source, a sink
  	@returns : a path
  	@notes : we supposed that the source and the sink are in the graph
*)
let find_path graph source sink =
  List.rev (parcours graph [source] [] sink [])

(*
	@brief : calculate the saturation of an arc
  	@param : an arc
  	@returns : the saturation (with option) 
*)
let calc_saturation_option arc =
    match arc with
    | None -> raise Not_found
    | Some (a,b) -> b-a

(* Optionless version of calc_saturation*)
let calc_saturation arc =
    let (a,b) = arc in
    b-a

(*
	@brief : find the smallest saturation on a path
  	@param : a graph, a path, a saturation (here max_int)
  	@returns : the smallest saturation 
*)
let rec find_flow_variation graph path var_min =
    match path with
    | [] -> raise (Failure "empty path")
    | n :: [] -> var_min
    | n :: m :: rest -> 
        let saturation = calc_saturation_option (find_arc graph n m) in
        (if saturation <  var_min
        then find_flow_variation graph (m :: rest) saturation
        else find_flow_variation graph (m :: rest) var_min)

(*
	@brief : add the saturation at the arcs on the given path
  	@param : a graph, a path, the saturation
  	@returns : the updated graph
*)
let rec update_graph graph path saturation =
    match path with
    | [] -> raise (Failure "empty path")
    | n :: [] -> graph
    | n :: m :: rest -> update_graph (add_arc_tuple graph n m saturation) (m :: rest) saturation

(*
	@brief : delete arcs with label = 0
  	@param : a graph
  	@returns : the updated graph
*)
let delete_void_arcs graph =
    e_fold graph add_arc_no_void (clone_nodes graph)
  

(*
	@brief : create the residual graph
  	@param : a graph
  	@returns : the residual graph
*)  
let create_temp_graph graph =
    let temp_graph = e_fold graph add_rev_arc graph in
    let temp_graph = gmap temp_graph (fun (a,b) -> b-a) in
    delete_void_arcs temp_graph
    



































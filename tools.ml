open Graph

let clone_nodes gr =
  let node_list = n_fold gr (fun l id -> id :: l) []
  in
  let rec loop graph = function
    | [] -> graph
    | id :: rest -> loop (new_node graph id) rest
  in
    loop empty_graph node_list
;;

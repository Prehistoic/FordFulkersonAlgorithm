open Graph

let clone_nodes gr =
    n_fold gr (fun gr_result id -> new_node gr_result id) empty_graph
;;

let gmap gr f =
    e_fold gr (fun new_gr id_out id_in lbl -> new_arc new_gr id_out id_in (f lbl)) (clone_nodes gr)
;;

let add_arc g id1 id2 n =
    match find_arc g id1 id2 with
    | None -> new_arc g id1 id2 n
    | Some lbl -> new_arc g id1 id2 (lbl+n)
;;

let add_arc_tuple g id1 id2 n =
    match find_arc g id1 id2 with
    | None -> new_arc g id1 id2 (n,n)
    | Some (a,b) -> new_arc g id1 id2 (a+n,b)
;;

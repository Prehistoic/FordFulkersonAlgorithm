open Graph
open Tools
open Ford_fulkerson

type path = string

let read_amount line =
    try Scanf.sscanf line "%d %d" (fun _ a -> a)
    with e ->
        Printf.printf "Cannot read amount in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

let read_amount_person line id =
    try Scanf.sscanf line "%d %d" (fun person a -> (if person=id then a else 0))
    with e ->
        Printf.printf "Cannot read amount in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

let amount_from_file path =

    let infile = open_in path in

    let rec loop l amount =
        try
            let line = input_line infile in

            let line = String.trim line in

            let (l2, amount2) =
                if line = "" then (l, amount)
                else (l+1, amount + (read_amount line))
            in
            loop l2 amount2
        with End_of_file -> amount (* Done *)
    in

    let final_amount = loop 0 0 in

    close_in infile ;
    final_amount

let get_diff path id due =

    let infile = open_in path in

    let rec loop l amount_paid =
        try
            let line = input_line infile in
            let line = String.trim line in
            let (l2, amount_paid2) =
                if line = "" then (l, amount_paid)
                else (l+1, amount_paid + (read_amount_person line id))
            in
            loop l2 amount_paid2
        with End_of_file -> amount_paid
    in

    let final_amount_paid = loop 0 0 in

    close_in infile ;
    final_amount_paid - due

let rec create_list_person path number_of_people dueperperson id acu =
    if id = number_of_people+1 then acu
    else create_list_person path number_of_people dueperperson (id+1) ((id, get_diff path id dueperperson) :: acu)


let rec create_nodes graph list_person =
    match list_person with
    | [] -> graph
    | (id,_) :: rest -> create_nodes (new_node graph id) rest

let rec create_arcs_to_source_or_sink graph list_person id_sink =
    match list_person with
    | [] -> graph
    | (id,amount) :: rest -> (if amount<0 then create_arcs_to_source_or_sink (new_arc graph 0 id (-amount)) rest id_sink
                              else create_arcs_to_source_or_sink (new_arc graph id id_sink amount) rest id_sink)

let rec loop_on_people graph n id =
    if n>0
    then (if n=id
          then loop_on_people graph (n-1) id
          else (match find_arc graph id n with
                | None -> loop_on_people (new_arc (new_arc graph id n max_int) n id max_int) (n-1) id
                | Some x -> loop_on_people graph (n-1) id)
         )
    else graph

let rec create_arcs_between_people graph list_person =
    match list_person with
    | [] -> graph
    | (id,_) :: rest -> create_arcs_between_people (loop_on_people graph (List.length list_person) id) rest

let create_graph graph list_person id_sink =
    let graph = new_node (new_node graph 0) id_sink in
    let graph = create_nodes graph list_person in
    let graph = create_arcs_to_source_or_sink graph list_person id_sink in
    let graph = create_arcs_between_people graph list_person in
    graph

let create_temp_graph_for_money_sharing graph =
    let temp_graph = e_fold graph add_rev_arc_source_sink graph in
    let temp_graph = gmap temp_graph (fun (a,b) -> (if b=max_int then b else b-a)) in
    delete_void_arcs temp_graph

let rec algo_loop_for_money_sharing graph source sink =
    let residual_graph = create_temp_graph_for_money_sharing graph in
    let path = find_path residual_graph source sink in
    match path with
    | [] -> graph
    | n :: rest ->
        let variation = find_flow_variation graph path max_int in
        algo_loop_for_money_sharing (update_graph graph path variation) source sink

let ford_fulkerson_for_money_sharing graph source sink =
    let tmp_graph = init graph in
    algo_loop_for_money_sharing tmp_graph source sink

let remove_empty_arcs graph =
    let result = clone_nodes graph in
    let result = e_fold graph add_arc_no_void_string result in
    result

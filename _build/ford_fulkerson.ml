open Tools
open Graph

let init graph = 
    gmap graph (fun s -> (0,int_of_string s))
    

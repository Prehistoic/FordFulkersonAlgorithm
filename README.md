# OCAML Project : Ford-Fulkerson Algorithm

This project includes both an implementation of the Ford-Fulkerson algorithm and an implementation of the money sharing problem, solved using a Ford-Fulkerson algorithm.

## Getting Started :

### Prerequisites:

- To run this program you need to have a recent Ocaml release installed (the version we used is "The OCaml toplevel, version 4.07.1")

### Compiling:

- To compile the Ford-Fulkerson algorithm implementation : ocamlbuild src/ftest.byte
- To compile the money sharing implementation : ocamlbuild src/money_sharing.byte

### Running:

- To run the Ford-Fulkerson algorithm implementation :
./ftest.byte infile id_source id_sink outfile formatted_file
- To run the money sharing implementation :
./money_sharing.byte infile number_of_people outfile formatted_file

Some test graphs can be found in the graph_test repositery.
You can then draw the graph using : dot -Tsvg formatted_file > PATH_TO_SVG_FILE.svg

## What's working / What's not working :

- Both the Ford-Fulkerson algorithm and the money sharing problem implementations are working
- However, the money sharing problem, despite offering a valid answer to the problem, doesn't offer the "best" answer as our path searching method doesn't look for the minimal path but stops when it finds any valid path.

## Authors :

- Matthieu Lacote
- Clément Gehin

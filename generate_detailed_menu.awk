#!/usr/bin/awk -f

BEGIN {
    in_node = 0
    node_name = ""
    FS = ","
}

/^@node/ {
    node_name = gensub(/^@node\s+([^,]+)/, "\\1",1,$1)
    in_node = 1
    node_line = $0
    comment_lines = ""
}

/^@comment/ {
    if (in_node == 1) {
        comment_lines = comment_lines $0 "\n"
    }
}

/^@chapter/ || /^@section/ {
    if (in_node == 1) {
        if ($0 ~ /^@chapter/) {
            title = gensub(/^@chapter\s+(.+)/, "\\1", "g")
            printf("\n%s.\n", title)
        } else if ($0 ~ /^@section/) {
            title = gensub(/^@section\s+(.+)/, "\\1", "g")
            printf("* %-33s::  %s.\n", node_name, title)
        }        
        in_node = 0
        node_name = ""
    }
}

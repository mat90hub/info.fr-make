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

/^@chapter/ {
    if (in_node == 1) {
        chapter_title = gensub(/^@chapter\s+(.+)/, "\\1", "g")
        printf("* %-33s::  %s.\n", node_name, chapter_title)
        in_node = 0
	node_name=""
    }
}

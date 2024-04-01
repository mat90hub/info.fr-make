awk "/@node/ {print $1}" FS="," make.fr.texi > "node.txt"

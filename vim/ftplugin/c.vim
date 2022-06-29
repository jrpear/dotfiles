" Set path using C preprocessor path
let &path = system("cpp -v </dev/null 2>&1 | sed -nE '/#include </ { n; :start; /\\nEnd.*$/{s///; s/[[:space:]]+/,/g; P; b;}; N; b start;}' | tr -d '\\n'")
set path+=.

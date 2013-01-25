# URL encode something and print it.
function url-encode; {
  setopt extendedglob
  echo "${${(j: :)@}//(#b)(?)/%$[[##16]##${match[1]}]}"
}

# Search google for the given keywords.
function google; { chromium "http://www.google.com/search?q=`url-encode "${(j: :)@}"`" </dev/null >/dev/null 2>&1 }

# Make directory and change to it
mdc() { mkdir -p "$1" && cd "$1" }


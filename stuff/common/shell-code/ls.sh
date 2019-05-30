alias lst="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
lst
https://erudinsky.com/2016/07/27/list-nice-file-structure-in-cli-tree-vs-ls

for gitdir in (find ~/repos -name ".git" -type d)
    complete -f -c repo -a "(basename (dirname \"$gitdir\"))"
end

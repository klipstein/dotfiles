for gitdir in (find ~/repos -name ".git" -type d)
    complete -f -c repodir -a "(basename (dirname \"$gitdir\"))"
end

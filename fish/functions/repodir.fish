function repodir
    set repo_base ~/repos
    set repo_path (find "$repo_base" -name ".git" -type d -path "*$argv*" | sed 's/\/\.git$//' | head -n 1)
    if not test "$argv"; or not test "$repo_path"
        set repo_path "$repo_base"
    end
    echo "$repo_path"
end

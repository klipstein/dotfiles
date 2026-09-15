function forrepos --description 'Evaluates $argv for all repo folders'
    for gitdir in (find ~/repos -name ".git" -type d)
        set d (dirname $gitdir)
        pushd $d
        set repo (basename $d)
        echo $repo
        eval (abbrex $argv)
        popd > /dev/null
    end
end

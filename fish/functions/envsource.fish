function envsource
  for line in (grep -v '^#' $argv)
    if test -n "$line"
      set key (string split -m 1 '=' -- $line)[1]
      set value (string split -m 1 '=' -- $line)[2]
      set -gx $key $value
      echo "Exported key $key"
    end
  end
end

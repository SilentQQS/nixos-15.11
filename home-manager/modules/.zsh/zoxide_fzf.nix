''
z() {
  if (( $# == 1 )); then
    local arg="$1"

    # Игнорировать относительные и абсолютные пути
    if [[ "$arg" == ~ || "$arg" == "." || "$arg" == ".." || "$arg" == /* || "$arg" == ./* || "$arg" == ../* ]]; then
      cd "$arg" || return
      return
    fi

    # Пытаемся найти через zoxide
    local target
    target=$(zoxide query "$arg" 2>/dev/null)

    if [[ -n $target && -d $target ]]; then
      cd "$target" || return
    else
      # FZF fallback
      local dir
      dir=$(fd -t d -i "$arg" . 2>/dev/null | fzf --height 40% --border --ansi --preview 'ls -l {}' --prompt "Directory search > ")

      if [[ -n $dir && -d $dir ]]; then
        cd "$dir" || return
        command zoxide add "$dir"
      else
        echo "❌ No matching directory found"
        return 1
      fi
    fi
  else
    # Любые другие аргументы перенаправляем zoxide напрямую
    command zoxide "$@"
  fi
}
''


{pkgs, ...}: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    shellAliases = import ./aliases.nix;

    plugins = with pkgs.fishPlugins; [
      {
        name = "foreign-env";
        src = foreign-env.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "done";
        inherit (pkgs.fishPlugins.done) src;
      }
      {
        name = "bass";
        src = bass.src;
      }
    ];

    interactiveShellInit = ''
      if test "$XDG_SESSION_TYPE" = "tty"
        echo "Start UWSM (loginctl terminate-user username)"
        if uwsm check may-start > /dev/null; and uwsm select
            exec systemd-cat -t uwsm_start uwsm start default
        end
      end

      set fish_greeting
      set fish_cursor_default block blink
      set fish_cursor_insert line blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual block

      set -U fish_color_command brgreen
      set -U fish_color_param white
      set -U fish_color_comment brblack
      set -U fish_color_cwd brblue
      set -U fish_color_valid_path brmagenta
      set -U fish_color_cwd_root brred
      set -U fish_color_error brred
      set -U fish_color_quote brgreen
      set -U fish_color_redirection bryellow
      set -U fish_color_operator brcyan
      set -U fish_color_escape brcyan
      set -U fish_color_end brblack
      set -U fish_color_autosuggestion 5c6370
      set -U fish_color_selection 'white' '--bold' '--background=blue'
      set -U fish_color_search_match 'black' '--background=brcyan'
      set -U fish_color_user brgreen
      set -U fish_color_host bryellow
      set -U fish_color_status red
      set -gx PATH ~/.npm-global/bin $PATH

      function fish_user_key_bindings
        fish_default_key_bindings -M insert
        fish_vi_key_bindings --no-erase insert
      end

      # Sponge: автоочистка дубликатов в history
      function sponge_history --on-event fish_preexec
        builtin history delete --exact --case-sensitive (commandline -b)
      end

      # function y # yazi-change-dir
      #   set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
      #   yazi $argv --cwd-file="$tmp"
      #   set -l cwd (cat "$tmp" 2>/dev/null)

      #   if test -n "$cwd" -a "$cwd" != "$PWD"
      #     cd "$cwd"
      #   end

      #   rm -f "$tmp"
      # end

      # Настройка плагина 'done'
      set -U __done_min_cmd_duration 5000  # default: 5000 ms
      set -U __done_notification_urgency_level low
      set -U __done_notification_urgency_level_failure normal
      set -U __done_notify_sound 1
      set -U __done_exclude '^git (?!push|pull|fetch)'  # default: all git commands
    '';
  };
}

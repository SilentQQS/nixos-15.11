{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = import ./aliases.nix;   

    history = {
      size = 10000;
    };

    initContent = ''
      PROMPT='%F{8}…%f '
      eval "$(${pkgs.starship}/bin/starship init zsh --print-full-init)"
      unset PROMPT

      # Быстрые опции Zsh
      setopt no_beep no_nomatch auto_cd extended_glob prompt_subst

      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      ${import ./zoxide_fzf.nix}

      # Загрузка основных плагинов сразу
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

      # Отложенная загрузка остальных плагинов через zsh-defer
      source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh
     
      zsh-defer source ${pkgs.zsh-completions}/share/zsh/site-functions/_git
      zsh-defer source ${pkgs.zsh-completions}/share/zsh/site-functions/_fzf
      zsh-defer source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      zsh-defer source ${pkgs.zsh-fzf-history-search}/share/zsh/zsh-fzf-history-search.plugin.zsh
      zsh-defer source ${pkgs.zsh-history-substring-search}/share/zsh/zsh-history-substring-search.zsh

      # thefuck alias кеширование
      if [ ! -f "${config.xdg.dataHome}/zsh/thefuck_alias.zsh" ]; then
        ${pkgs.thefuck}/bin/thefuck --alias f > "${config.xdg.dataHome}/zsh/thefuck_alias.zsh"
      fi
      source "${config.xdg.dataHome}/zsh/thefuck_alias.zsh"

      autoload -U history-substring-search

      # fzf-history-widget
      export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border"
      if command -v fzf >/dev/null; then
      	fzf-history-widget() {
        	local selected
        	selected=$(fc -l 1 |fzf +s --tac | sed 's/ *[0-9]* *//') || return  # если Ctrl+C, выйдем без изменений
        	LBUFFER=$selected
        	zle reset-prompt  # перерисовать prompt, чтобы starship не пропадал
        }
        zle -N fzf-history-widget
        bindkey '^R' fzf-history-widget
      fi
 


      zsh-defer() {
      	builtin autoload -Uz compinit && builtin compinit
      }


    '';
  };
  programs.zsh.loginExtra = ''
  # Start UWSM (only if needed)
  if uwsm check may-start > /dev/null && uwsm select; then
    exec systemd-cat -t uwsm_start uwsm start default
  fi
  '';


 # home.packages = with pkgs; [
 #   zsh-defer
 #   zsh-autosuggestions
 #   zsh-fast-syntax-highlighting
 #   zsh-completions
 #   zsh-fzf-tab
 #   zsh-fzf-history-search
 #   zsh-you-should-use
 #   zsh-history-substring-search
 #
 #   eza
 #   thefuck
 #   zoxide
 #   fzf
 # ];
}


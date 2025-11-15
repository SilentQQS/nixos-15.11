{ pkgs, ... }:
{
  programs = {
    nushell = { enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    #  configFile.source = "";
      # for editing directly to config.nu 
      extraConfig = ''
       zoxide init nushell | save -f ~/.zoxide.nu
       let carapace_completer = {|spans|
       carapace $spans.0 nushell ...$spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
       '';
       shellAliases = {
       l = "eza --icons --all";
       d = "eza --icons --all --only-dirs";
       ll = "eza --icons --all --long";
       lt = "eza --all --tree";
       lt1 = "eza --icons --all --long --tree --level=1";
       lt2 = "eza --all --long --tree --level=2";
       lt3 = "eza --all --long --tree --level=3";
       lt4 = "eza --all --long --tree --level=4";
       lg = "eza --icons --all --long --git";

       };
   };  
   carapace.enable = true;
   carapace.enableNushellIntegration = true;
   
   starship.enableNushellIntegration = true;
  };
}

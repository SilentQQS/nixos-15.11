{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      add_newline = false;

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      #  vicmd_symbol = "[❮](bold blue)";
        vimcmd_symbol = "[N](bold blue)";
        vimcmd_visual_symbol = "[V](bold red)";
        vimcmd_replace_one_symbol = "[R](bold purple)";
        vimcmd_replace_symbol = "[R](bold purple)";
      };

      directory = {
          read_only = " ";
          truncation_length = 7;
          truncation_symbol = "… /";
          style = "bold cyan";
      };
    
    #  time = {
    #      format = "[$time]($style) ";
    #      style = "bold blue";
    #      disabled = false;
    #  }; 

      git_branch = {
        format = "[$branch]($style)";
        style = "bold yellow";
      };

      git_status = {
        format = "([$all_status]($style))";
        style = "red";
        ignore_submodules = true;
        disabled = false;
      };
      
     # status = {
     #     format = "[$symbol]($style) ";
     #     symbol = "[](bold red)";
     #     success_symbol = "[](bold green)";
     #     disabled = false;
     # };

      git_commit = {
        only_detached = false;
        tag_disabled = false;
        style = "dimmed green";
      };

      cmd_duration = {
        min_time = 700;
        format = "[$duration]($style) ";
        style = "bold yellow";
      };

      nix_shell = {
          symbol = " ";
      };

      docker_context = {
        format = " [$context](bold blue)";
      };

      hostname = {
        ssh_only = true;
        format = "[$ssh_symbol$hostname]($style) ";
        style = "bold purple";
      };

      username = {
        disabled = true;
      };

      package = {
        disabled = false;
        format = " [$symbol$version]($style) ";
        style = "bold green";
      };

      jobs = {
        format = "jobs: [$number]($style) ";
        style = "bold purple";
      };

      line_break = {
        disabled = false;
      };

      direnv = {
        format = "direnv [$version]($style) ";
        style = "bold green";
      };

      shlvl = {
        format = "shlvl: [$shlvl]($style) ";
        style = "bold cyan";
      };

      battery = { disabled = true; };
      gcloud = { disabled = true; };
      kubernetes = { disabled = true; };
      aws = { disabled = true; };
      java = { disabled = true; };
      perl = { disabled = true; };
      nodejs = { disabled = true; };
      terraform = { disabled = true; };
      memory_usage = { disabled = true; };

      rust = {
        format = "via [  $version](red bold) ";
        disabled = false;
        detect_extensions = [ "rs" ];
        detect_files = [ "Cargo.toml" ];
      };
      
      golang = {
          style = "blue";
          symbol = "via [  $version](bold cyan) ";
      };

      python = {
        format = "via [  $version](yellow bold) ";
        disabled = false;
        detect_extensions = [ "py" ];
        detect_files = [ "requirements.txt" "pyproject.toml" ".python-version" ];
      };

      c = {
        format = "via [ 🅒 $version](blue bold) ";
        disabled = false;
        detect_extensions = [ "c" "h" ];
        detect_files = [ "CMakeLists.txt" "Makefile" ];
      };

      cpp = {
        format = "via [ 🅒++ $version](blue bold) ";
        disabled = false;
        detect_extensions = [ "cpp" "cxx" "cc" "hpp" "hxx" ];
        detect_files = [ "CMakeLists.txt" "Makefile" ];
      };

      cmake = {
        format = "via [ 🛠 $version](cyan bold) ";
        disabled = false;
        detect_files = [ "CMakeLists.txt" "CMakeCache.txt" ];
      };

      lua = {
        format = "via [ $version](blue bold) ";
        disabled = false;
        detect_extensions = [ "lua" ];
      };

     # shell = {
     #   format = "[$indicator]($style) ";
     #   style = "white";
     #   disabled = false;
     # };
    };
  };
}

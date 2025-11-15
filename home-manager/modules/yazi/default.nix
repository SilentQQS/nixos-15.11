{
  config,
  unstablePkgs,
  lib,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    package = unstablePkgs.yazi;
    initLua = "require(\"starship\"):setup()
require(\"git\"):setup()
require(\"projects\"):setup({
    save = {
        method = \"yazi\", -- yazi | lua
        yazi_load_event = \"@projects-load\", -- event name when loading projects in \`yazi\` method
        lua_save_path = \"\", -- path of saved file in \`lua\` method, comment out or assign explicitly
                            -- default value:
                            -- windows: \"%APPDATA%/yazi/state/projects.json\"
                            -- unix: \"~/.local/state/yazi/projects.json\"
    },
    last = {
        update_after_save = true,
        update_after_load = true,
        load_after_start = false,
    },
    merge = {
        event = \"projects-merge\",
        quit_after_merge = false,
    },
    event = {
        save = {
            enable = true,
            name = \"project-saved\",
        },
        load = {
            enable = true,
            name = \"project-loaded\",
        },
        delete = {
            enable = true,
            name = \"project-deleted\",
        },
        delete_all = {
            enable = true,
            name = \"project-deleted-all\",
        },
        merge = {
            enable = true,
            name = \"project-merged\",
        },
    },
    notify = {
        enable = true,
        title = \"Projects\",
        timeout = 3,
        level = \"info\",
    },
})
      ";
    plugins = {
      "bypass" = unstablePkgs.yaziPlugins.bypass;
      "chmod" = unstablePkgs.yaziPlugins.chmod;
      # "full-border" = unstablePkgs.yaziPlugins.full-border;
      "lazygit" = unstablePkgs.yaziPlugins.lazygit;
      "mediainfo" = unstablePkgs.yaziPlugins.mediainfo;
      # "no-status" = unstablePkgs.yaziPlugins.no-status;
      "ouch" = unstablePkgs.yaziPlugins.ouch;
      "restore" = unstablePkgs.yaziPlugins.restore;
      # "smart-enter" = unstablePkgs.yaziPlugins.smart-enter;
      "toggle-pane" = unstablePkgs.yaziPlugins.toggle-pane;
      "piper" = unstablePkgs.yaziPlugins.piper;
      # "smart-filter" = unstablePkgs.yaziPlugins.smart-filter;
      "starship" = unstablePkgs.yaziPlugins.starship;
      "projects" = unstablePkgs.yaziPlugins.projects;
      "git" = unstablePkgs.yaziPlugins.git;
      "sudo" = unstablePkgs.yaziPlugins.sudo;
      "mount" = unstablePkgs.yaziPlugins.mount;
      "jump-to-char" = unstablePkgs.yaziPlugins.jump-to-char;
      # "relative-motions" = unstablePkgs.yaziPlugins.relative-motions;
    };
    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        show_symlink = true;
        ratio = [1 3 3];
        linemode = "size";
      };
      preview = {
        max_width = 800;
        max_height = 1000;
        cache_dir = "${config.xdg.cacheHome}/yazi";
      };
      opener = {
        play = [
          {
            run = ''mpv "$@"'';
            orphan = true;
            for = "unix";
          }
          {
            run = ''mediainfo "$1"; echo "Press enter to exit"; read _'';
            block = true;
            desc = "Show media info";
            for = "unix";
          }
        ];
        open_photo = [
          {
            run = ''aseprite "$@"'';
            orphan = true;
            for = "unix";
          }
        ];
        edit = [
          {
            run = ''$EDITOR "$@"'';
            desc = "edit";
            block = true;
            for = "unix";
          }
          {
            run = ''doas $EDITOR "$@"'';
            block = true;
            for = "unix";
            desc = "doas edit";
          }
        ];
        open = [
          {
            run = ''              swayimg "$@" $(find "$PWD" -maxdepth 1 -type f \( \
                -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.jxl" \
                -o -iname "*.png" \
                -o -iname "*.gif" \
                -o -iname "*.svg" \
                -o -iname "*.webp" \
                -o -iname "*.heif" -o -iname "*.avif" \
                -o -iname "*.tiff" -o -iname "*.tif" \
                -o -iname "*.sixel" \
                -o -iname "*.crw" -o -iname "*.cr2" -o -iname "*.nef" -o -iname "*.raf" \
                -o -iname "*.exr" \
                -o -iname "*.bmp" \
                -o -iname "*.pnm" \
                -o -iname "*.tga" \
                -o -iname "*.qoi" \
                -o -iname "*.dcm" \
                -o -iname "*.farbfeld" \
                        \))'';
            orphan = true;
            for = "unix";
            mime = "image/*";
            desc = "swayimg";
          }
          {
            run = ''swayimg -r'';
            orphan = true;
            for = "unix";
            mime = "image/*";
            desc = "swayimg -r";
          }
          {
            run = ''xdg-open "$@"'';
            desc = "open";
          }
        ];
        reveal = [
          {
            run = ''wl-copy < "$@"'';
            desc = "wl-copy";
            for = "linux";
          }
          {
            run = ''blobdrop "$@"'';
            desc = "blobdrop";
            for = "linux";
          }
          {
            run = ''xdg-open "$(dirname "$1")"'';
            desc = "Reveal";
            for = "linux";
          }
          {
            run = ''clear; exiftool "$1"; echo "Press enter to exit"; read _'';
            block = true;
            desc = "Show EXIF";
            for = "unix";
          }
        ];
        extract = [
          {
            run = "7zz x \"$@\"";
            desc = "Extract here with 7zz";
            for = "unix";
          }
        ];
      };
      open = {
        rules = [
          # Folder
          {
            name = "*/";
            use = ["edit" "open" "reveal"];
          }
          # Text
          {
            mime = "text/*";
            use = ["edit" "reveal"];
          }
          # Image
          {
            mime = "image/*";
            use = ["open" "reveal" "open_photo"];
          }
          # Media
          {
            mime = "{audio,video}/*";
            use = ["play" "reveal"];
          }
          # Archive
          {
            mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
            use = ["extract" "reveal"];
          }
          # JSON
          {
            mime = "application/{json,ndjson}";
            use = ["edit" "reveal"];
          }
          {
            mime = "*/javascript";
            use = ["edit" "reveal"];
          }
          # Empty file
          {
            mime = "inode/empty";
            use = ["edit" "reveal"];
          }
          # Fallback
          {
            name = "*";
            use = ["open" "reveal"];
          }
        ];
      };
      tasks = {
        micro_workers = 10;
        macro_workers = 10;
        bizarre_retry = 3;
        image_alloc = 1073741824; # 1024MB
        image_bound = [5000 5000];
        suppress_preload = false;
      };

      plugin = {
        fetchers = [
          {
            id = "mime";
            name = "*";
            run = "mime";
            prio = "high";
          }
        ];
        spotters = [
          {
            name = "*/";
            run = "folder";
          }
          {
            mime = "text/*";
            run = "code";
          }
          {
            mime = "application/{mbox,javascript,wine-extension-ini}";
            run = "code";
          }
          {
            mime = "image/{avif,hei?,jxl}";
            run = "magick";
          }
          {
            mime = "image/svg+xml";
            run = "svg";
          }
          {
            mime = "image/*";
            run = "image";
          }
          {
            mime = "video/*";
            run = "video";
          }
          {
            name = "*";
            run = "file";
          }
        ];
        preloaders = [
          {
            mime = "image/{avif,hei?,jxl}";
            run = "magick";
          }
          {
            mime = "image/svg+xml";
            run = "svg";
          }
          {
            mime = "image/*";
            run = "image";
          }
          {
            mime = "video/*";
            run = "video";
          }
          {
            mime = "application/pdf";
            run = "pdf";
          }
          {
            mime = "font/*";
            run = "font";
          }
          {
            mime = "application/ms-opentype";
            run = "font";
          }
        ];
        previewers = [
          {
            name = "*/";
            run = "folder";
          }
          {
            mime = "text/*";
            run = "code";
          }
          {
            mime = "application/{mbox,javascript,wine-extension-ini}";
            run = "code";
          }
          {
            mime = "application/{json,ndjson}";
            run = "json";
          }
          {
            mime = "image/{avif,hei?,jxl}";
            run = "magick";
          }
          {
            mime = "image/svg+xml";
            run = "svg";
          }
          {
            mime = "image/*";
            run = "image";
          }
          {
            mime = "video/*";
            run = "video";
          }
          {
            mime = "application/pdf";
            run = "pdf";
          }
          {
            mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
            run = "archive";
          }
          {
            mime = "application/{debian*-package,redhat-package-manager,rpm,android.package-archive}";
            run = "archive";
          }
          {
            name = "*.{AppImage,appimage}";
            run = "archive";
          }
          {
            mime = "application/{iso9660-image,qemu-disk,ms-wim,apple-diskimage}";
            run = "archive";
          }
          {
            mime = "application/virtualbox-{vhd,vhdx}";
            run = "archive";
          }
          {
            name = "*.{img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}";
            run = "archive";
          }
          {
            mime = "font/*";
            run = "font";
          }
          {
            mime = "application/ms-opentype";
            run = "font";
          }
          {
            mime = "inode/empty";
            run = "empty";
          }
          {
            name = "*";
            run = "file";
          }
        ];
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
        prepend_preloaders = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
        ];
        prepend_previewers = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/*zip";
            run = "ouch";
          }
          {
            mime = "application/x-tar";
            run = "ouch";
          }
          {
            mime = "application/x-bzip2";
            run = "ouch";
          }
          {
            mime = "application/x-7z-compressed";
            run = "ouch";
          }
          {
            mime = "application/x-rar";
            run = "ouch";
          }
          {
            mime = "application/vnd.rar";
            run = "ouch";
          }
          {
            mime = "application/x-xz";
            run = "ouch";
          }
          {
            mime = "application/xz";
            run = "ouch";
          }
          {
            mime = "application/x-zstd";
            run = "ouch";
          }
          {
            mime = "application/zstd";
            run = "ouch";
          }
          {
            mime = "application/java-archive";
            run = "ouch";
          }
          {
            name = "*.csv";
            run = "piper -- bat --color=always \"$1\"";
          }
          # {
          #   name = "*/";
          #   run = "piper -- eza -TL=3 --color=always --icons=always --group-directories-first --no-quotes \"$1\"";
          # }
        ];
      };
      input = {
        cursor_blink = false;

        # cd
        cd_title = "Change directory:";
        cd_origin = "top-center";
        cd_offset = [0 2 50 3];

        # create
        create_title = ["Create:" "Create (dir):"];
        create_origin = "top-center";
        create_offset = [0 2 50 3];

        # rename
        rename_title = "Rename:";
        rename_origin = "hovered";
        rename_offset = [0 1 50 3];

        # filter
        filter_title = "Filter:";
        filter_origin = "top-center";
        filter_offset = [0 2 50 3];

        # find
        find_title = ["Find next:" "Find previous:"];
        find_origin = "top-center";
        find_offset = [0 2 50 3];

        # search
        search_title = "Search via {n}:";
        search_origin = "top-center";
        search_offset = [0 2 50 3];

        # shell
        shell_title = ["Shell:" "Shell (block):"];
        shell_origin = "top-center";
        shell_offset = [0 2 50 3];
      };

      confirm = {
        # trash
        trash_title = "Trash {n} selected file{s}?";
        trash_origin = "center";
        trash_offset = [0 0 70 20];

        # delete
        delete_title = "Permanently delete {n} selected file{s}?";
        delete_origin = "center";
        delete_offset = [0 0 70 20];

        # overwrite
        overwrite_title = "Overwrite file?";
        overwrite_content = "Will overwrite the following file:";
        overwrite_origin = "center";
        overwrite_offset = [0 0 50 15];

        # quit
        quit_title = "Quit?";
        quit_content = "The following tasks are still running, are you sure you want to quit?";
        quit_origin = "center";
        quit_offset = [0 0 50 15];
      };

      pick = {
        open_title = "Open with:";
        open_origin = "hovered";
        open_offset = [0 1 50 7];
      };

      which = {
        sort_by = "none";
        sort_sensitive = false;
        sort_reverse = false;
        sort_translit = false;
      };
    };
  };

  xdg.configFile."yazi/theme.toml".source = lib.mkForce ./theme.toml;
  xdg.configFile."yazi/keymap.toml".source = lib.mkForce ./keymap.toml;
}

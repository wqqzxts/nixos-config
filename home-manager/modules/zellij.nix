{ config, lib, pkgs, ... }:
let
  zjstatus = pkgs.zellijPlugins.zjstatus;

  barPlugin = pkgs.writeText "zjstatus-plugin.kdl" ''
    plugin location="file:${zjstatus}" {
        format_left  "{mode} {tabs}"
        format_space ""

        mode_normal       "#[bg=blue,fg=black,bold] NORMAL "
        mode_locked       "#[bg=red,fg=black,bold] LOCKED "
        mode_scroll       "#[bg=yellow,fg=black,bold] SCROLL "
        mode_enter_search "#[bg=yellow,fg=black,bold] SEARCH "
        mode_search       "#[bg=yellow,fg=black,bold] SEARCH "
        mode_rename_tab   "#[bg=cyan,fg=black,bold] RENAME "
        mode_rename_pane  "#[bg=cyan,fg=black,bold] RENAME "
        mode_session      "#[bg=cyan,fg=black,bold] SESSION "
        mode_pane         "#[bg=cyan,fg=black,bold] PANE "
        mode_tab          "#[bg=cyan,fg=black,bold] TAB "
        mode_resize       "#[bg=cyan,fg=black,bold] RESIZE "
        mode_move         "#[bg=cyan,fg=black,bold] MOVE "
        mode_prompt       "#[bg=cyan,fg=black,bold] PROMPT "
        mode_tmux         "#[bg=cyan,fg=black,bold] TMUX "

        tab_normal    "#[bg=bright_black,fg=white] {name} "
        tab_active    "#[bg=magenta,fg=black,bold] {name} "
        tab_separator "#[bg=default] "
    }
  '';

  barLayouts = pkgs.runCommand "zellij-bar-layouts" { nativeBuildInputs = [ config.programs.zellij.package ]; } ''
    export HOME=$TMPDIR XDG_CACHE_HOME=$TMPDIR/cache XDG_DATA_HOME=$TMPDIR/data
    mkdir -p $out
    zellij setup --dump-layout compact > $out/bar.kdl
    zellij setup --dump-swap-layout compact > $out/bar.swap.kdl
    for f in $out/bar.kdl $out/bar.swap.kdl; do
      substituteInPlace $f --replace-fail 'plugin location="compact-bar"' "$(cat ${barPlugin})"
    done
  '';
in
{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "default";
      default_layout = "bar";
      default_mode = "normal";
      mouse_mode = true;
      copy_command = "wl-copy";
      scroll_buffer_size = 100000;
      scrollback_editor = "nvim";

      session_serialization = true;
      serialize_pane_viewport = true;
      scrollback_lines_to_serialize = 10000;

      show_release_notes = false;
      show_startup_tips = false;
    };

    extraConfig = ''
      keybinds {
          shared_except "locked" {
              unbind "Ctrl g" "Ctrl q" "Ctrl p" "Ctrl t" "Ctrl n" "Ctrl s" "Ctrl o" "Ctrl h" "Ctrl b"

              bind "Alt Space" { EditScrollback; }
              bind "Alt g" { SwitchToMode "Locked"; }

              bind "Alt 1" { GoToTab 1; }
              bind "Alt 2" { GoToTab 2; }
              bind "Alt 3" { GoToTab 3; }
              bind "Alt 4" { GoToTab 4; }
              bind "Alt 5" { GoToTab 5; }
              bind "Alt 6" { GoToTab 6; }
              bind "Alt 7" { GoToTab 7; }
              bind "Alt 8" { GoToTab 8; }
              bind "Alt 9" { GoToTab 9; }

              bind "Alt h" { MoveFocus "Left"; }
              bind "Alt l" { MoveFocus "Right"; }
              bind "Alt k" { MoveFocus "Up"; }
              bind "Alt j" { MoveFocus "Down"; }

              bind "Ctrl Alt h" { Resize "Increase Left"; }
              bind "Ctrl Alt l" { Resize "Increase Right"; }
              bind "Ctrl Alt k" { Resize "Increase Up"; }
              bind "Ctrl Alt j" { Resize "Increase Down"; }

              bind "Alt Shift h" { MovePane "Left"; }
              bind "Alt Shift l" { MovePane "Right"; }
              bind "Alt Shift k" { MovePane "Up"; }
              bind "Alt Shift j" { MovePane "Down"; }

              bind "Alt s" { NewPane "Down"; }
              bind "Alt v" { NewPane "Right"; }

              bind "Alt t" { NewTab; }
              bind "Alt c" { CloseFocus; }
              bind "Alt d" { Detach; }
              bind "Alt Shift q" { CloseTab; }
              bind "Alt q" { SwitchToMode "Normal"; }
          }
          locked {
              unbind "Ctrl g"
              bind "Alt g" { SwitchToMode "Normal"; }
          }
      }
    '';
  };

  xdg.configFile."zellij/layouts/bar.kdl".source = "${barLayouts}/bar.kdl";
  xdg.configFile."zellij/layouts/bar.swap.kdl".source = "${barLayouts}/bar.swap.kdl";

  home.activation.zjstatusPermissions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    perms="${config.xdg.cacheHome}/zellij/permissions.kdl"
    if [[ ! -v DRY_RUN ]] && ! grep -qsF '"${zjstatus}"' "$perms"; then
      mkdir -p "$(dirname "$perms")"
      cat >> "$perms" <<'EOF'
    "${zjstatus}" {
        ReadApplicationState
        ChangeApplicationState
        RunCommands
    }
    EOF
    fi
  '';
}

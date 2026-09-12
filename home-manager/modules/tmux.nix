{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "tmux-256color";
    extraConfig = ''
      set -g history-limit 10000

      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -as terminal-features ",alacritty*:RGB"
      set -as terminal-features ",xterm-256color:RGB"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{1}%d::%p2%{1}%d::%p3%{1}%d;%m\E[pm'

      bind -n M-Space copy-mode -u

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      bind -n M-C-h resize-pane -L 5
      bind -n M-C-l resize-pane -R 5
      bind -n M-C-k resize-pane -U 3
      bind -n M-C-j resize-pane -D 3

      bind -n M-s split-window -v
      bind -n M-v split-window -h

      bind -n M-t new-window
      bind -n M-c kill-pane
      bind -n M-q send-keys ""
      bind -n M-d detach
      bind -n M-Q kill-window

      # block accidental shell-exit via Ctrl-D (EOF closes the pane), but
      # let it through to nvim so it still works as half-page-down
      bind -n C-d if-shell -F '#{==:#{pane_current_command},nvim}' 'send-keys C-d' 'send-keys ""'
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };
}

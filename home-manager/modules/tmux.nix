{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "screen-256color";
    prefix = "C-a";
    extraConfig = ''
      unbind C-b
      set -as terminal-features ",alacritty*:RGB"
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
      bind -n M-q kill-window
      bind -n M-d detach
      bind -n M-Q kill-session
    '';
    plugins = with pkgs; [
      tmuxPlugins.gruvbox
      # {
      #   plugin = tmuxPlugins.resurrect;
      #   extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      # }
      # {
      #   plugin = tmuxPlugins.continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-save-interval '60' # minutes
      #   '';
      # }
    ];
  };
}

{ config, lib, pkgs, ... }:
let
  shellConfig = pkgs.runCommand "quickshell-shell" { } ''
    cp -r ${./shell} $out
    chmod -R u+w $out
    substituteInPlace $out/Modules/DashboardModule.qml \
      --replace-fail 'command: ["cava", ' 'command: ["${pkgs.cava}/bin/cava", '
  '';

  qs = "${config.programs.quickshell.package}/bin/qs";
in
{
  programs.quickshell = {
    enable = true;
    configs.shell = shellConfig;
    activeConfig = "shell";
  };

  systemd.user.services.quickshell = {
    Unit = {
      Description = "quickshell desktop shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" "pipewire.service" "pipewire-pulse.service" ];
    };
    Service = {
      ExecStart = "${qs} -p ${shellConfig}";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  home.packages = [
    pkgs.grim
    (pkgs.writeShellScriptBin "shell-ipc" ''
      exec ${qs} -p ${shellConfig} ipc call "$@"
    '')
    (pkgs.writeShellScriptBin "bar-ipc" ''
      exec ${qs} -p ${shellConfig} ipc call "$@"
    '')
    (pkgs.writeShellScriptBin "bar-toggle" ''
      exec ${qs} -p ${shellConfig} ipc call bar toggle
    '')
  ];
}

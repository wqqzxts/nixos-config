{ lib, pkgs, user, ... }:
let
  service = "clashtui_mihomo";
  coreDir = "/var/lib/clashtui/mihomo";
  configDir = "${coreDir}/config";

  systemctl = "/run/current-system/sw/bin/systemctl";
  trueBin = "/run/current-system/sw/bin/true";

  capabilities = [
    "CAP_NET_ADMIN"
    "CAP_NET_RAW"
    "CAP_NET_BIND_SERVICE"
    "CAP_SYS_PTRACE"
    "CAP_DAC_READ_SEARCH"
  ];
in {
  environment.systemPackages = with pkgs; [ clashtui mihomo ];

  users.groups.mihomo = { };
  users.users.mihomo = {
    isSystemUser = true;
    group = "mihomo";
    description = "mihomo core";
  };

  users.users.${user}.extraGroups = [ "mihomo" ];

  boot.kernelModules = [ "tun" ];

  systemd.tmpfiles.rules = [
    "d /var/lib/clashtui 0755 root root -"
    "d ${coreDir} 0755 root root -"
    "d ${configDir} 2775 mihomo mihomo -"
    "f ${configDir}/config.yaml 0664 mihomo mihomo -"
  ];

  systemd.services.${service} = {
    description = "mihomo daemon, managed by clashtui";
    documentation = [ "https://wiki.metacubex.one/" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    unitConfig.ConditionFileNotEmpty = "${configDir}/config.yaml";

    serviceConfig = {
      Type = "simple";
      User = "mihomo";
      Group = "mihomo";
      UMask = "0002";
      WorkingDirectory = configDir;
      ExecStart = "${lib.getExe pkgs.mihomo} -d ${configDir}";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      RestartSec = 3;
      LimitNPROC = 500;
      LimitNOFILE = 1000000;
      AmbientCapabilities = capabilities;
      CapabilityBoundingSet = capabilities;
      NoNewPrivileges = true;
      ProtectHome = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectClock = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallArchitectures = "native";
    };
  };

  security.sudo.extraRules = [
    {
      users = [ user ];
      commands = map (command: { inherit command; options = [ "NOPASSWD" ]; }) ([
        trueBin
      ] ++ map (verb: "${systemctl} ${verb} ${service}") [
        "start"
        "stop"
        "restart"
        "reload"
        "try-restart"
      ]);
    }
  ];
}

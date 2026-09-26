{ pkgs, ... }:
let
  yaml = pkgs.formats.yaml { };

  configDir = "/var/lib/clashtui/mihomo/config";

  config = {
    mihomo = {
      core = {
        config_dir = configDir;
        bin_path = "${pkgs.mihomo}/bin/mihomo";
        config_path = "${configDir}/config.yaml";
      };
      core_service = {
        service_name = "clashtui_mihomo";
        is_user = false;
      };
    };

    timeout = 5;

    extra = {
      edit_cmd = ''alacritty -e nvim "%s"'';
      open_dir_cmd = ''alacritty -e yazi "%s"'';
    };
  };

  coreOverride = {
    mixed-port = 7890;
    allow-lan = false;
    ipv6 = false;
    mode = "rule";
    log-level = "info";
    unified-delay = true;
    tcp-concurrent = true;
    external-controller = "127.0.0.1:9090";
    secret = "";
    geo-auto-update = true;
    geo-update-interval = 7;

    profile = {
      store-selected = true;
      store-fake-ip = true;
    };

    dns.enable = false;
    tun.enable = false;
  };
in {
  xdg.configFile = {
    "clashtui/config.yaml".source = yaml.generate "clashtui-config.yaml" config;
    "clashtui/mihomo/core_override_config.yaml".source =
      yaml.generate "clashtui-core-override.yaml" coreOverride;
  };
}

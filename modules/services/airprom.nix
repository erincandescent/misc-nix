{ config, lib, pkgs, ... }:

 with lib;

 let 
  cfg = config.services.airprom;
in {
  options.services.airprom = {

    instances = mkOption {
      description = "Instances of airprom to run";
      
      type = with types; attrsOf (submodule {
        options = {
          enable = mkEnableOption "Enable this instance of airprom";
    
          port = mkOption {
            description = "port to listen on";
            type = int; 
            default = 5000;
          };

          listenHost = mkOption { 
            description = "host to listen on";
            type = str;
            default = "::0";
          };

          host = mkOption {
            description = "host to poll";
            type = str;
            default = "192.68.1.3";
          };
        };
      });
    };

    package = mkOption {
      default = pkgs.airprom;
      defaultText = "pkgs.airprom";
      type = types.package;
      description = "airprom package to use.";
    };
 };

  config = {
    systemd.services = lib.attrsets.mapAttrs' (name: value: lib.attrsets.nameValuePair ("airprom-${name}") {
      description = "airprom instance ${name}";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target"  ];
      serviceConfig = {
        ExecStart = ''${cfg.package}/bin/airprom.py --listen ${value.listenHost} --port ${toString value.port} ${value.host}'';
        Type = "simple";
        DynamicUser = true;
        Restart = "on-failure";
        StartLimitInterval = 86400;
        StartLimitBurst = 5;
        AmbientCapabilities = "cap_net_bind_service";
        CapabilityBoundingSet = "cap_net_bind_service";
        NoNewPrivileges = true;
        LimitNPROC = 64;
        LimitNOFILE = 1048576;
        ProtectSystem = "full";
        RuntimeDirectory = "%N";
        WorkingDirectory = "%t/%N";
      };
    }) cfg.instances;
  };
}

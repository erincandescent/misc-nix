{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.services.nomad;
in {
  options.services.nomad = {
    enable = mkEnableOption "A Distributed, Highly Available, Datacenter-Aware Scheduler";

    package = mkOption {
      default = pkgs.nomad;
      defaultText = "pkgs.nomad";
      type = types.package;
      description = "Nomad package to use.";
    };
    
    config = mkOption {
      type = types.json;
      description = "Configuration for the Nomad agent";
    };
  };

  config = let
    nomadCfg = writeText "nomad.json" (builtins.toJSON cfg.config); 
  in mkIf cfg.enable {
    systemd.services.nomad =  mkMerge [
      {
        description = "Nomad container/VM orchestration tool";
        after = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart             = "${cfg.package.bin}/bin/nomad agent -config ${nomadCfg}";
          ExecReload            = "${pkgs.utillinux.bin}/bin/kill -HUP $MAINPID";
          KillMode              = "process";
          KillSignal            = "SIGINT";
          LimitNOFILE           = 65536;
          LimitNPROC            = "infinity";
          Restart               = "on-failure";
          RestartSec            = 2;
          StartLimitBurst       = 3;
          StartLimitIntervalSec = 10;
          TasksMax              = "infinity";
          OOMScoreAdjust        = -1000;
        };
      }
      (mkIf config.services.consul.enable {
        # When using Nomad with Consul it is not necessary to start Consul first. These
        # lines start Consul before Nomad as an optimization to avoid Nomad logging
        # that Consul is unavailable at startup.
        after = [ "consul.service" ];
        wants = [ "consul.service" ];
      })
    ];
  };
}

{ config, lib, pkgs, ... }:

 with lib;

 let 
  cfg = config.services.consulmux;
in {
  options.services.consulmux = {
    enable = mkEnableOption "ConsulMux web server";

     package = mkOption {
      default = pkgs.consulmux;
      defaultText = "pkgs.consulmux";
      type = types.package;
      description = "ConsulMux package to use.";
    };
 };

   config = mkIf cfg.enable {
    systemd.services.consulmux = {
      description = "ConsulMux Webserver";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''${cfg.package.bin}/bin/consulmux tcp :80'';
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
      };
    };
    systemd.sockets.consulmux = {
      description = "ConsulMux socket";
      wantedBy = [ "sockets.target" ];
      listenStreams = [ "80" ];
    };
  };
}

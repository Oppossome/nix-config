{ self, inputs, ... }: {
    flake.nixosModules.programsGamingSteam = { pkgs, ... }: {
        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };
        
        programs.gamemode.enable = true;
    };
}
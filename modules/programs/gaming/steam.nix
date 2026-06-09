{ self, inputs, ... }: {
	flake.nixosModules.programsGamingSteam = { pkgs, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		services.flatpak.packages = [
			"com.valvesoftware.Steam"
		];

		programs.steam.remotePlay.openFirewall = true;
		programs.steam.dedicatedServer.openFirewall = true;		
		programs.gamemode.enable = true;
	};
}
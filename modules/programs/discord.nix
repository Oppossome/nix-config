{ self, inputs, ... }: {
	flake.nixosModules.programsDiscord = { pkgs, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		services.flatpak.packages = [
			"com.discordapp.Discord"
		];
	};
}
{ self, inputs, ... }: {
	flake.nixosModules.programsGamingItch = { pkgs, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		services.flatpak.packages = [
			"io.itch.itch"
		];
	};
}
{ self, inputs, ... }: {
	flake.nixosModules.programsGamingItch = { pkgs, helpers, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [ "io.itch.itch" ];
		}) ["gaming"];
	};
}
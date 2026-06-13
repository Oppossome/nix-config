{ self, inputs, ... }: {
	flake.nixosModules.programsGamingItch = { pkgs, helpers, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [ "io.itch.itch" ];
		}) ["gaming"];
	};
}
{ self, inputs, ... }: {
	flake.nixosModules.programsGamingProtonPlus = { pkgs, helpers, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [
				"com.vysp3r.ProtonPlus"
			];
		}) ["gaming"];
	};
}
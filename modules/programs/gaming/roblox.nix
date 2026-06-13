{ self, inputs, ... }: {
	flake.nixosModules.programsGamingRoblox = { pkgs, helpers, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [
				"org.vinegarhq.Sober"
				"org.vinegarhq.Vinegar"
			];
		}) ["gaming"];
	};
}
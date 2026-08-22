{ self, inputs, ... }: {
	flake.nixosModules.programsGamingItch = { pkgs, helpers, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			home.packages = with pkgs; [ itch ];
		}) ["gaming"];
	};
}